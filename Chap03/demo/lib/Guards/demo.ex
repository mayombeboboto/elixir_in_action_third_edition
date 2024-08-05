defmodule Guards.Demo do
  @moduledoc false

  def square_root(num) when is_integer(num) and num >= 0 do
    :math.sqrt(num)
  end

  def square_root(_num) do
    {:error, :invalid_input}
  end
end
