defmodule SimpleRegistry do
  @moduledoc """
  Documentation for `SimpleRegistry`.
  """
  use GenServer

  def start_link() do
    GenServer.start_link(
      __MODULE__,
      nil,
      name: __MODULE__
    )
  end

  def register(name) do
    case :ets.lookup(__MODULE__, name) do
      [] ->
        :ets.insert(__MODULE__, {name, self()})
        :ok
      [{^name, _pid}] ->
        :error
    end
  end

  def whereis(name) do
    case :ets.lookup(__MODULE__, name) do
      [] -> nil
      [{^name, pid}] -> pid
    end
  end

  def init(nil) do
    :ets.new(__MODULE__, [:named_table, :public])
    {:ok, nil}
  end

  def handle_cast(_msg, state), do: {:noreply, state}
  def handle_info(_msg, state), do: {:noreply, state}
  def handle_call(_msg, _from, state), do: {:reply, :unknown, state}
end
