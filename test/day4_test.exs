defmodule Day4_test do
  use ExUnit.Case
  doctest Day4

  test "Test the day 4 puzzle 1 against the example file" do
    assert Day4.puzzle1("test/testfiles/day4_test.txt") == 13
  end

  test "Test the day 4 puzzle 2 against the example file" do
    assert Day4.puzzle2("test/testfiles/day4_test.txt") == 30
  end
end
