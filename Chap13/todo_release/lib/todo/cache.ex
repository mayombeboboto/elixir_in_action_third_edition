defmodule Todo.Cache do
  alias Todo.Server
  # APIs
  @spec start_link() :: {:ok, pid()}
  def start_link() do
    IO.puts("Starting to-do cache.")

    DynamicSupervisor.start_link(
      name: __MODULE__,
      strategy: :one_for_one
    )
  end

  @spec child_spec(term()) :: map()
  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end

  @spec server_process(binary()) :: pid()
  def server_process(todo_list_name) do
    existing_process(todo_list_name) || new_process(todo_list_name)
  end

  # Internal functions
  defp existing_process(todo_list_name) do
    Server.whereis(todo_list_name)
  end

  defp new_process(todo_list_name) do
    case DynamicSupervisor.start_child(
           __MODULE__,
           {Server, todo_list_name}
         ) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end
end
