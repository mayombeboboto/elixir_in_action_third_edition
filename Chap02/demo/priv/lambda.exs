Enum.each([1, 2, 3], fn x -> IO.puts(x) end) # Long form
Enum.each([1, 2, 3], &IO.puts/1) # Capture Operator

lambda = fn x, y, z -> x * y + z end # Long form
lambda = &(&1 * &2 + &3) # Capture Operator

# Closure
outside_var = 5
lambda = fn -> IO.puts(outside_var) end
outside_var = 6
lambda.() #=> prints 5
