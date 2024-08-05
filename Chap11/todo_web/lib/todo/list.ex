defmodule Todo.List do
  @moduledoc """
  Documentation for `TodoList`.
  """
  defstruct next_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(entries, %__MODULE__{}, &add_entry(&2, &1))
  end

  def add_entry(%__MODULE__{next_id: next_id, entries: entries} = todo_list, entry) do
    entry = Map.put(entry, :id, next_id)
    new_entries = Map.put(entries, next_id, entry)

    %__MODULE__{todo_list | entries: new_entries, next_id: next_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(&(&1.date == date))
  end

  def update_entry(%__MODULE__{entries: entries} = todo_list, entry_id, updater_fun) do
    with {:ok, entry} <- Map.fetch(entries, entry_id),
         {:ok, new_entry} <- updater_fun.(entry) do
      %__MODULE__{todo_list | entries: Map.put(entries, entry_id, new_entry)}
    else
      _error -> todo_list
    end
  end

  defimpl String.Chars do
    def to_string(%Todo.List{} = todo_list) do
      inspect(todo_list)
    end
  end
end
