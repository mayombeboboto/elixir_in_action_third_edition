defmodule Calculator.Demo do
  @moduledoc false

  @spec add(number(), number()) :: number()
  def add(num1, num2 \\ 0), do: num1 + num2
end
