defmodule Todo.Server do
  use GenServer

  # APIs
  @spec start_link(binary()) :: {:ok, pid()}
  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
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
  def init(name) do
    {:ok, {name, nil}, {:continue, :my_init}}
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, {name, todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, {name, todo_list}) do
    new_list = Todo.List.add_entry(todo_list, entry)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_continue(:my_init, {name, nil}) do
    todo_list = Todo.Database.get(name) || Todo.List.new()
    {:noreply, {name, todo_list}}
  end

  @impl GenServer
  def handle_info(_info, todo_list) do
    {:noreply, todo_list}
  end
end
