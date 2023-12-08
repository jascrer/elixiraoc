defmodule Day7_test do
  use ExUnit.Case
  doctest Day7

  test "Test the day 7 puzzle 1 against the example file" do
    assert Day7.puzzle1("test/testfiles/day7_test.txt") == 6440
  end

  test "Test the day 7 puzzle 2 against the example file" do
    assert Day7.puzzle2("test/testfiles/day7_test.txt") == 5905
  end


end
