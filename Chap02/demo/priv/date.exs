{:ok, ~D[2024-05-07] = date} = Date.new(2024, 5, 7)
date = ~D[2024-05-07] = Date.utc_today()

date.year #=> 2024
date.month #=> 5

Date.from_iso8601!("2015-01-23") #=> ~D[2015-01-23]
Date.to_string(~D[2015-01-23]) #=> "2015-01-23"

Date.day_of_week(~D[2024-07-01]) #=> 1 => Monday
