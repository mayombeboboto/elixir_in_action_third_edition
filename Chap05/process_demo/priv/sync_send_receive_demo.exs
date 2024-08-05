# Operation within Pid1
send(pid, {self(), some_message})

receive do
  {:response, response} -> response
end

# Pid2
receive do
  {caller_pid, message} ->
    send(caller_pid, {:respone, message})
end
