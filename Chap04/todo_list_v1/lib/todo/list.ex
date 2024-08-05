defmodule Todo.List do

  def new() do
    Map.new()
  end

  def add_entry(todo_list, date, entry) do
    todo_list
    |> Map.update(date, [entry], &([entry|&1]))
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end
end
