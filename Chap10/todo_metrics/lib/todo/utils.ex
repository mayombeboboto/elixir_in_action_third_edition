defmodule Todo.Utils do
  @doc false
  def file_name(db_folder, key) do
    Path.join(db_folder, to_string(key))
  end
end
