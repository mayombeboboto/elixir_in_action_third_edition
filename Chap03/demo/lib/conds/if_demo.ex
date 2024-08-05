defmodule Conds.IfDemo do
  @moduledoc false

  def max(value1, value2) do
    if value1 > value2 do
      value1
    else
      value2
    end
  end
end
