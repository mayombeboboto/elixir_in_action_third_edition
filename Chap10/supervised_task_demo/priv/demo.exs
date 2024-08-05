Task.Supervisor.start_link(name: MyTaskSupervisor)

Task.Supervisor.start_child(
  MyTaskSupervisor,
  fn ->
    IO.puts("Task started")
    Process.sleep(2000)
    IO.puts("Task stopping")
  end,
  restart: :transient,
  shutdown: 5000
)
