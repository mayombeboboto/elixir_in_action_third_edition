defmodule Conds.CondDemo do
  @moduledoc false

  def day() do
    day_of_week = Date.day_of_week(DateTime.utc_now())

    cond do
      day_of_week == 1 -> "Monday"
      day_of_week == 2 -> "Tuesday"
      day_of_week == 3 -> "Wednesday"
      day_of_week == 4 -> "Thursday"
      day_of_week == 5 -> "Friday"
      true -> "Weekend"
    end
  end
end
