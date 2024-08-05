defmodule Todo.Database do
  use GenServer
  alias Todo.DatabaseWorker

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
    {:ok, start_workers(@db_folder)}
  end

  @impl true
  def handle_cast({:store, key, data}, workers) do
    choose_worker(key, workers)
    |> GenServer.cast({:store, key, data})

    {:noreply, workers}
  end

  @impl true
  def handle_call({:get, key}, _from, workers) do
    reply =
      choose_worker(key, workers)
      |> GenServer.call({:get, key})

    {:reply, reply, workers}
  end

  # Internal Functions
  defp start_workers(path) do
    1..3
    |> Enum.reduce(%{}, fn key, map ->
      {:ok, pid} = DatabaseWorker.start(path)
      Map.put(map, key, pid)
    end)
  end

  defp choose_worker(key, workers) do
    Map.fetch!(workers, :erlang.phash2(key, 3))
  end
end
