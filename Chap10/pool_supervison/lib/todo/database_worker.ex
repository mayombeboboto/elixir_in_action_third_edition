defmodule Todo.DatabaseWorker do
  use GenServer
  alias Todo.Utils

  @type id() :: integer()
  # APIs

  @spec start_link({binary(), id()}) :: {:ok, pid()}
  def start_link({db_folder, worker_id}) do
    GenServer.start_link(
      __MODULE__,
      db_folder,
      name: via_tuple(worker_id)
    )
  end

  @spec store(id(), binary(), map()) :: no_return()
  def store(worker_id, key, value) do
    GenServer.cast(via_tuple(worker_id), {:store, key, value})
  end

  @spec get(id(), binary()) :: list()
  def get(worker_id, key) do
    GenServer.call(via_tuple(worker_id), {:get, key})
  end

  # Callbacks
  @impl true
  def init(db_folder) do
    IO.puts("Starting database worker.")
    {:ok, db_folder}
  end

  @impl true
  def handle_cast({:store, key, data}, db_folder) do
    spawn(fn ->
      Utils.file_name(db_folder, key)
      |> File.write!(:erlang.term_to_binary(data))
    end)

    {:noreply, db_folder}
  end

  @impl true
  def handle_call({:get, key}, from, db_folder) do
    spawn(fn ->
      data =
        case File.read(Utils.file_name(db_folder, key)) do
          {:ok, contents} -> :erlang.binary_to_term(contents)
          _error -> nil
        end

      GenServer.reply(from, data)
    end)

    {:noreply, db_folder}
  end

  defp via_tuple(worker_id) do
    Todo.ProcessRegistry.via_tuple({__MODULE__, worker_id})
  end
end
