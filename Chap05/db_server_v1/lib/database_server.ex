defmodule DatabaseServer do
  @moduledoc """
  Documentation for `DatabaseServer`.
  """

  def start do
    spawn(&loop/0)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result() do
    receive do
      {:query_result, result} -> result
    after 5000 -> {:error, :timeout}
    end
  end

  def loop do
    receive do
      {:run_query, caller, query_def} ->
        query_result = run_query(query_def)
        send(caller, {:query_result, query_result})
    end
    loop()
  end

  defp run_query(query_def) do
    Process.sleep(2000)
    "#{query_def} result"
  end
end
