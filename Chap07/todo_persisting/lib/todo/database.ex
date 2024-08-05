defmodule Todo.Database do
  use GenServer

  @db_folder "./persist"

  # APIs
  @spec start() :: {:ok, pid()}
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # Callbacks
  @impl true
  def init(nil) do
    File.mkdir_p!(@db_folder)
    {:ok, nil}
  end

  @impl true
  def handle_cast({:store, key, data}, state) do
    spawn(fn ->
      key
      |> file_name()
      |> File.write!(:erlang.term_to_binary(data))
    end)

    {:noreply, state}
  end

  @impl true
  def handle_call({:get, key}, from, state) do
    spawn(fn ->
      data = case File.read(file_name(key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _error -> nil
      end
      GenServer.reply(from, data)
    end)

    {:noreply, state}
  end

  # Internal Functions
  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
