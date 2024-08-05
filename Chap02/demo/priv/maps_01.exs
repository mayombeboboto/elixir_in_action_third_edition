# Map creation
empty_map = %{}

squares = %{1 => 1, 2 => 4, 3 => 9}

squares = Map.new([{1, 1}, {2, 4}, {3, 9}])

# Fetch
squares[2] #=> 4
squares[4] #=> nil

Map.get(squares, 2) #=> 4
Map.get(squares, 4) #=> nil

Map.get(squares, 4, :not_found) #=> :not_found

Map.fetch(squares, 2) #=> {:ok, 4}
Map.fetch(squares, 4) #=> :error

Map.fetch!(squares, 2) #=> 4
Map.fetch!(squares, 4) #=> ** (KeyError)

# Put
squares = Map.put(squares, 4, 16)
Map.fetch!(squares, 4) #=> 16
