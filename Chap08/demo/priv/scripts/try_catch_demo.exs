try_helper = fn fun ->
  try do
    fun.()
    IO.puts("No error.")

  catch type, value ->
    IO.puts("""
    Error
      #{inspect(type)}
      #{inspect(value)}
    """)
  end
end

try_helper.(fn -> raise("Something went wrong") end)
# Error
#   :error
#   %RuntimeError{message: "Something went wrong"}

try_helper.(fn -> throw("Thrown value") end)
# Error
#   :throw
#   "Thrown value"

try_helper.(fn -> exit("I'm done") end)
# Error
#   :exit
#   "I'm done"
