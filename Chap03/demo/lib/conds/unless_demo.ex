defmodule Conds.UnlessDemo do
  @moduledoc false

  def max(value1, value2) do
    unless value1 > value2 do
      value2
    else
      value1
    end
  end
end
