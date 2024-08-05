defmodule Todo.Server do
  use GenServer

  # APIs
  @spec start(list()) :: {:ok, pid()}
  def start(entries \\ []) do
    GenServer.start(__MODULE__, entries)
  end

  @spec add_entry(pid(), map()) :: no_return()
  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  @spec entries(pid(), NaiveDateTime.t()) :: list()
  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  # Callbacks

  @impl GenServer
  def init(entries) do
    {:ok, Todo.List.new(entries)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, todo_list) do
    {:reply, Todo.List.entries(todo_list, date), todo_list}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, todo_list) do
    {:noreply, Todo.List.add_entry(todo_list, entry)}
  end

  @impl GenServer
  def handle_info(_info, todo_list) do
    {:noreply, todo_list}
  end
end
