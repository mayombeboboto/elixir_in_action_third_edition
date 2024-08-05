defmodule Todo.DatabaseWorker do
  use GenServer
  alias Todo.Utils

  # APIs

  @spec start_link(binary()) :: {:ok, pid()}
  def start_link(db_folder) do
    GenServer.start_link(__MODULE__, db_folder)
  end

  @spec store(pid(), binary(), map()) :: no_return()
  def store(pid, key, value) do
    GenServer.cast(pid, {:store, key, value})
  end

  @spec get(pid(), binary()) :: list()
  def get(pid, key) do
    GenServer.call(pid, {:get, key})
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
end
