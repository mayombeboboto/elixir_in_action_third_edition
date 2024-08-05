Mix.install([{:jason, "~> 1.4"}])

input = hd(System.argv())
decoded = Jason.decode!(input)

IO.inspect(decoded)

# elixir scripts/json_decode.exs '{"some_key": 42}'
