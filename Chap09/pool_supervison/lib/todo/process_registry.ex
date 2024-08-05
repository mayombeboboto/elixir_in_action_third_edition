defmodule Todo.ProcessRegistry do
  def start_link do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  def via_tuple(key) do
    # __MODULE__ => Registry name
    # key => {Client Module, ID}
    {:via, Registry, {__MODULE__, key}}
  end

  def child_spec(_) do
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: {__MODULE__, :start_link, []}
    )
  end
end
