days = MapSet.new([:monday, :tuesday, :wednesday])

MapSet.member?(days, :monday) #=> true

days = MapSet.put(days, :thursday)

# MapSet is enumerable
Enum.each(days, &IO.puts/1)
# monday
# thursday
# tuesday
# wednesday
