defmodule TodoServer do
  @moduledoc """
  Documentation for `TodoServer`.
  """

  def start() do
    spawn(fn -> loop(TodoList.new()) end)
    |> Process.register(__MODULE__)
  end

  def add_entry(entry) do
    send(__MODULE__, {:add_entry, entry})
  end

  def entries(date) do
    send(__MODULE__, {:entries, date, self()})

    receive do
      {:response, todo_list} ->
        todo_list
    after
      5000 ->
        {:error, :timeout}
    end
  end

  def loop(state) do
    state =
      receive do
        msg -> handle_msg(msg, state)
      end

    loop(state)
  end

  defp handle_msg({:add_entry, entry}, todo_list) do
    TodoList.add_entry(todo_list, entry)
  end

  defp handle_msg({:entries, date, caller}, todo_list) do
    entries = TodoList.entries(todo_list, date)
    send(caller, {:response, entries})
    todo_list
  end
end
