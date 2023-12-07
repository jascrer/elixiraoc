defmodule Day7_test do
  use ExUnit.Case
  doctest Day7

  test "Test the day 7 against the example file" do
    assert Day7.puzzle1("test/testfiles/day7_test.txt") == 6440
  end


end
