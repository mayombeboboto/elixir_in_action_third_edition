range = 1..2

2 in range #=> true
7 in range #=> false

1..10//2 #=> Range with step
.. #=> 0..-1//1 from 0 to -1, nothing

3..1//-1 #=> Negative step
Enum.to_list(1..10//2) #=> [1, 3, 5, 7, 9]
Enum.to_list(..) #=> []

# Range is enumerable!
Enum.each(1..3, &IO.puts/1) #=> 1\n2\n3
