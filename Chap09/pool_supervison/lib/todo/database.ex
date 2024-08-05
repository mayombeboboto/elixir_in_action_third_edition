defmodule Todo.Database do
  alias Todo.DatabaseWorker

  @pool_size 3
  @db_folder "./persist"

  # APIs
  @spec start_link() :: {:ok, pid()}
  def start_link() do
    IO.puts("Starting database server.")
    File.mkdir_p!(@db_folder)

    children = Enum.map(1..@pool_size, &worker_spec/1)
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  @spec store(binary(), map()) :: no_return()
  def store(key, value) do
    key
    |> choose_worker()
    |> DatabaseWorker.store(key, value)
  end

  @spec get(binary()) :: list()
  def get(key) do
    key
    |> choose_worker()
    |> DatabaseWorker.get(key)
  end

  @spec child_spec(term()) :: map()
  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end

  # Internal Functions
  defp worker_spec(worker_id) do
    default_worker_spec = {DatabaseWorker, {@db_folder, worker_id}}
    Supervisor.child_spec(default_worker_spec, id: worker_id)
  end

  defp choose_worker(key) do
   :erlang.phash2(key, @pool_size) + 1
  end
end
