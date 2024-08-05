defmodule Todo.Utils do
  @doc false
  def file_name(path, key) do
    Path.join(path, to_string(key))
  end
end
