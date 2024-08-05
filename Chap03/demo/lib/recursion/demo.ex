defmodule Recursion.Demo do
  @moduledoc false

  def print_natural_numbers(1) do
    IO.puts(1)
  end

  def print_natural_numbers(num) when is_integer(num) and num > 0 do
    print_natural_numbers(num - 1)
    IO.puts(num)
  end

  def sum([]), do: 0

  def sum([head|tail]) when is_number(head) do
    head + sum(tail)
  end

  def sum_tail(list), do: sum_tail(list, 0)

  defp sum_tail([], sum), do: sum

  defp sum_tail([head|tail], sum) when is_number(head) do
    sum_tail(tail, head + sum)
  end
end
