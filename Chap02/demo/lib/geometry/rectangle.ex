defmodule Geometry.Rectangle do
  @moduledoc false

  @spec area(number()) :: number()
  def area(side), do: area(side, side)

  @spec area(number(), number()) :: number()
  def area(length, width), do: length * width
end
