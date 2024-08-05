defmodule Calculator do
  @moduledoc """
  Documentation for `Calculator`.
  """
  def start do
    spawn(fn -> loop(0) end)
  end

  def add(server, value), do: send(server, {:add, value})
  def sub(server, value), do: send(server, {:sub, value})
  def mul(server, value), do: send(server, {:mul, value})
  def div(server, value), do: send(server, {:div, value})

  def value(server) do
    send(server, {:value, self()})
    receive do
      {:response, value} ->
        value
    end
  end

  def loop(current_value) do
    new_value =
      receive do
        {:value, caller} ->
          send(caller, {:response, current_value})
          current_value
        {:add, value} -> current_value + value
        {:sub, value} -> current_value - value
        {:mul, value} -> current_value * value
        {:div, value} -> current_value / value
        invalid_request ->
          IO.puts("Invalid request #{inspect(invalid_request)}")
          current_value
      end
      loop(new_value)
  end
end
