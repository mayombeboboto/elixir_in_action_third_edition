defmodule Ets.KeyValue do
  use GenServer
  @ets_opts [:named_table, :public, write_concurrency: true]
  def start_link do
    GenServer.start_link(
      __MODULE__,
      nil,
      name: __MODULE__
    )
  end

  def put(key, value) do
    :ets.insert(__MODULE__, {key, value})
  end

  def get(key) do
    case :ets.lookup(__MODULE__, key) do
      [{^key, value}] -> value
      [] -> nil
    end
  end

  def init(nil) do
    :ets.new(__MODULE__, @ets_opts)
    {:ok, nil}
  end

  def handle_cast(_msg, state), do: {:noreply, state}
  def handle_info(_msg, state), do: {:noreply, state}
  def handle_call(_msg, _from, state), do: {:reply, :unknown, state}
end
