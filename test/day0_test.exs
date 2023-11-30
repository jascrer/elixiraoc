defmodule Day0_test do
  use ExUnit.Case
  doctest Day0

  test "Test the day 0 against the example file" do
    assert Day0.puzzle1("test/testfiles/day0_test.txt") == "Day 0 Test"
  end
end
