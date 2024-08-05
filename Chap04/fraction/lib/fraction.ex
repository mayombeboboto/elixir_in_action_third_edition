defmodule Fraction do
  @moduledoc """
  Documentation for `Fraction`.
  """

  defstruct [:num, :denom]

  def new(numerator \\ 1, denominator \\1) do
    %__MODULE__{num: numerator, denom: denominator}
  end

  def add(%__MODULE__{} = fract1, %__MODULE__{} = fract2) do
    %__MODULE__{
      num: fract1.num * fract2.denom + fract2.num * fract1.denom,
      denom: fract1.denom * fract2.denom
    }
  end

  def value(%__MODULE__{} = fraction) do
    fraction.num / fraction.denom
  end
end
