defmodule KvStore do
  @moduledoc """
  Documentation for `KvStore`.
  """
  use GenServer
  @cleanup_interval :timer.seconds(5)

  # APIs
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # Callback functions
  @impl GenServer
  def init(nil) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl GenServer
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl GenServer
  def handle_info(:cleanup, state) do
    {:noreply, state}
  end
end
