defmodule Geometry.Demo do
  @moduledoc false
  alias :math, as: Math

  def area({:rectangle, width, breadth}), do: width * breadth

  def area({:circle, radius}), do: radius * radius * Math.pi()

  def area({:square, side}), do: side * side
end
