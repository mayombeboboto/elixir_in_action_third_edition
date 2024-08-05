defmodule Todo.DatabaseWorker do
  use GenServer
  alias Todo.Utils

  # APIs

  @spec start(binary()) :: {:ok, pid()}
  def start(path) do
    GenServer.start(__MODULE__, path)
  end

  # Callbacks
  @impl true
  def init(path) do
    {:ok, path}
  end

  @impl true
  def handle_cast({:store, key, data}, path) do
    spawn(fn ->
      Utils.file_name(path, key)
      |> File.write!(:erlang.term_to_binary(data))
    end)

    {:noreply, path}
  end

  @impl true
  def handle_call({:get, key}, from, path) do
    spawn(fn ->
      data =
        case File.read(Utils.file_name(path, key)) do
          {:ok, contents} -> :erlang.binary_to_term(contents)
          _error -> nil
        end

      GenServer.reply(from, data)
    end)

    {:noreply, path}
  end
end
