defmodule Guards.MultiClauseLambda do
  @moduledoc false

  def square_root(number) do
    fun = fn
      x when is_number(x) and x >= 0 -> :math.sqrt(x)
      _x -> {:error, :invalid_args}
    end

    fun.(number)
  end
end
