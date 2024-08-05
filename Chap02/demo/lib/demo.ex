defmodule Demo do
  @moduledoc """
  Documentation for `Demo`.
  """
  alias Calculator.Demo, as: Calculator
  alias Geometry.{Circle, Rectangle}

  @spec add_num(number(), number()) :: number()
  def add_num(num1, num2) do
    Calculator.add(num1, num2)
  end

  @spec rectangle_area(number(), number()) :: number()
  def rectangle_area(length, width) do
    Rectangle.area(length, width)
  end

  @spec circle_area(number()) :: number()
  def circle_area(radius), do: Circle.area(radius)
end
