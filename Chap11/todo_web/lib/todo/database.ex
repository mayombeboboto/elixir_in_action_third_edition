defmodule Todo.Database do
  alias Todo.DatabaseWorker

  @db_folder "./persist"

  # APIs
  @spec child_spec(term()) :: map()
  def child_spec(_) do
    File.mkdir_p!(@db_folder)

    :poolboy.child_spec(
      __MODULE__,
      [
        name: {:local, __MODULE__},
        worker_module: DatabaseWorker,
        size: 3
      ],
      [@db_folder]
    )
  end

  @spec store(binary(), map()) :: no_return()
  def store(key, value) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        DatabaseWorker.store(worker_pid, key, value)
      end
    )
  end

  @spec get(binary()) :: list()
  def get(key) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        DatabaseWorker.get(worker_pid, key)
      end
    )
  end
end
