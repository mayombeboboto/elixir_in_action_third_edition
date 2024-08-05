defmodule TodoList do

  def new() do
    Map.new()
  end

  def add_entry(todo_list, %{date: date} = entry) do
    todo_list
    |> Map.update(date, [entry], &([entry|&1]))
  end

  def entries(todo_list, date) do
    todo_list
    |> Map.take(date)
    |> Map.get(date, [])
  end
end
