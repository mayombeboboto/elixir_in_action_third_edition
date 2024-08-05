binary = <<1, 2, 3>>

<<b1, b2, b3>> = binary #=> b1 = 1, b2 = 2, b3 = 3
<<b1, rest :: binary>> = binary #=> b1 = 1, rest = <<2, 3>>
