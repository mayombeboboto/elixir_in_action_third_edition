defmodule Streams.Demo do
  @moduledoc false

  def infinite_stream() do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.take(10)
  end
end
