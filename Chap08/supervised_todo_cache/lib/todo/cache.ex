defmodule Todo.Cache do
  use GenServer

  # APIs
  @spec start_link(term()) :: {:ok, pid()}
  def start_link(_value), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @spec server_process(binary()) :: pid()
  def server_process(todo_list_name) do
    GenServer.call(__MODULE__, {:server_process, todo_list_name})
  end

  # Callbacks
  @impl GenServer
  def init(_arg) do
    IO.puts("Starting to-do cache.")
    Todo.Database.start_link()
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      :error ->
        IO.puts("Starting to-do server for #{inspect(todo_list_name)}")
        {:ok, new_server} = Todo.Server.start_link(todo_list_name)

        {
          :reply,
          new_server,
          Map.put(todo_servers, todo_list_name, new_server)
        }
    end
  end
end
