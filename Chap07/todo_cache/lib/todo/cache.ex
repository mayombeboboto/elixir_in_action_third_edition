defmodule Todo.Cache do
  use GenServer

  # APIs
  @spec start() :: {:ok, pid()}
  def start(), do: GenServer.start(__MODULE__, nil)

  @spec server_process(pid(), binary()) :: pid()
  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end

  # Callbacks
  @impl GenServer
  def init(_arg), do: {:ok, %{}}

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}
      :error ->
        {:ok, new_server} = Todo.Server.start()
        {
          :reply,
          new_server,
          Map.put(todo_servers, todo_list_name, new_server)
        }
    end
  end
end
