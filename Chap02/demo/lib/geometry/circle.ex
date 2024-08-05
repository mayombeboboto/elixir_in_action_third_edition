defmodule Geometry.Circle do
  @moduledoc false

  alias :math, as: Math
  @pi Math.pi()

  @spec area(number()) :: float()
  def area(radius), do: Math.pow(radius, 2) * @pi

  @spec circumference(number()) :: float()
  def circumference(radius), do: 2 * radius * @pi
end
