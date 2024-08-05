defmodule Todo.Database do
  alias Todo.DatabaseWorker

  # APIs
  @spec child_spec(term()) :: map()
  def child_spec(_) do
    db_settings = Application.fetch_env!(:todo, :database)

    # Node name is used to determine the database folder. This allows us to
    # start multiple nodes from the same folders, and data will not clash.
    [name_prefix, _] = "#{node()}" |> String.split("@")
    db_folder = "#{Keyword.fetch!(db_settings, :db_folder)}/#{name_prefix}/"

    File.mkdir_p!(db_folder)

    :poolboy.child_spec(
      __MODULE__,
      [
        name: {:local, __MODULE__},
        worker_module: DatabaseWorker,
        size: 3
      ],
      [db_folder]
    )
  end

  @spec store(binary(), map()) :: no_return()
  def store(key, value) do
    {_results, bad_nodes} =
      :rpc.multicall(
        __MODULE__,
        :store_local,
        [key, value],
        :timer.seconds(5)
      )

    Enum.each(bad_nodes, &IO.puts("Store failed on node #{&1}"))
    :ok
  end

  @spec store(binary(), map()) :: no_return()
  def store_local(key, data) do
    :poolboy.transaction(__MODULE__, fn worker_pid ->
      Todo.DatabaseWorker.store(worker_pid, key, data)
    end)
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
