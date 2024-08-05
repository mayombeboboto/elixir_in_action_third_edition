run_query =
  fn query_def ->
    Process.sleep(2000)
    "#{query_def} result"
  end

async_query =
  fn query_def ->
    spawn(fn ->
      query_result = run_query.(query_def)
      IO.puts(query_result)
    end)
  end

Enum.each(1..5, &async_query.("query #{&1}"))
