defmodule FractionTest do
  use ExUnit.Case
  doctest Fraction

  test "greets the world" do
    assert Fraction.hello() == :world
  end
end
