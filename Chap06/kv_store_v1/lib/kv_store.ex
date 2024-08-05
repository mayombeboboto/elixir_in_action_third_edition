defmodule KvStore do
  @moduledoc """
  Documentation for `KvStore`.
  """
  use GenServer
  @cleanup_interval :timer.seconds(5)

  # APIs
  def start do
    GenServer.start(__MODULE__, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  # Callback functions
  @impl GenServer
  def init(nil) do
    :timer.send_interval(@cleanup_interval, :cleanup)
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
    IO.puts("performing cleanup...")
    {:noreply, state}
  end
end
