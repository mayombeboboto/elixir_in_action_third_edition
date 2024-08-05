# Receive - After
receive do
  message -> IO.inspect(message)
after
  5000 -> IO.puts("message not received")
end
