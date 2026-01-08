defmodule SniperTest do
  use ExUnit.Case
  doctest Sniper

  test "greets the world" do
    assert Sniper.hello() == :world
  end
end
