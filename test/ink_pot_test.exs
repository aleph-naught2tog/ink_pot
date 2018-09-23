defmodule InkPotTest do
  use ExUnit.Case
  doctest InkPot

  test "greets the world" do
    assert InkPot.hello() == :world
  end
end
