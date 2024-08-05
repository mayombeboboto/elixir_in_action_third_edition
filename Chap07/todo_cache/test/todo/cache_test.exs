defmodule Todo.CacheTest do
  use ExUnit.Case
  alias Todo.{Cache, Server}

  test "server_process" do
    {:ok, cache} = Cache.start()
    bob_pid = Cache.server_process(cache, "bob")

    assert bob_pid !=  Cache.server_process(cache, "alice")
    assert bob_pid ==  Cache.server_process(cache, "bob")
  end

  test "to-do operations" do
    {:ok, cache} = Cache.start()
    alice = Cache.server_process(cache, "alice")
    Server.add_entry(alice, %{date: ~D[2023-12-19], title: "Dentist"})

    entries = Server.entries(alice, ~D[2023-12-19])
    assert [%{date: ~D[2023-12-19], title: "Dentist"}] = entries
  end
end
