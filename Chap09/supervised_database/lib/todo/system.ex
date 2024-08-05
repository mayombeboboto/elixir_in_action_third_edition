defmodule Todo.System do
  def start_link do
    Supervisor.start_link(
      [Todo.Database, Todo.Cache],
      strategy: :one_for_one
    )
  end
end

# defmodule Todo.System do
#   use Supervisor

#   def start_link do
#     Supervisor.start_link(__MODULE__, nil)
#   end

#   def init(nil) do
#     Supervisor.init([Todo.Cache], strategy: :one_for_one)
#   end
# end
