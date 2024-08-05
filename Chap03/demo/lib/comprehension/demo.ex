defmodule Comprehension.Demo do
  @moduledoc false

  def multiplication_table_v1() do
    for x <- 1..9, y <- 1..9, x <= y do
      {{x, y}, x * y}
    end
  end

  def multiplication_table_v2() do
    for x <- 2..9, y <- 2..9, x >= y, into: %{} do
      {{x, y}, x * y}
    end
  end
end
