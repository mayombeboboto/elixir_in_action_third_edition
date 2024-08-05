days = [{:monday, 1}, {:tuesday, 2}, {:wednesday, 3}]
days = [monday: 1, tuesday: 2, wednesday: 3]

Keyword.get(days, :monday) #=> 1
Keyword.get(days, :unknown) #=> nil
days[:monday] #=> 1

# Optional arguments
IO.inspect([100, 200, 300])

IO.inspect([100, 200, 300], [width: 3])
# [100,
#  200,
#  300]
# [100, 200, 300]

IO.inspect([100, 200, 300], [label: :numbers])
#=> prints numbers: [100, 200, 300]

# Omitting square brackets in case the options are the last element
IO.inspect([100, 200, 300], label: :numbers)
