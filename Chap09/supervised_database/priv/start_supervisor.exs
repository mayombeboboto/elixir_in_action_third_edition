Supervisor.start_link(
  [
    %{
      id: Todo.Cache,
      start: {Todo.Cache, :start_link, [nil]}
    }
  ],
  strategy: :one_for_one
)

Supervisor.start_link(
  [{Todo.Cache, nil}],
  strategy: :one_for_one
)
