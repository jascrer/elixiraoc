defmodule Day8_test do
  use ExUnit.Case
  doctest Day8

  test "Test the day 8 puzzle 1 against the example file" do
    assert Day8.puzzle1("test/testfiles/day8_test1.txt") == 2
    assert Day8.puzzle1("test/testfiles/day8_test2.txt") == 6
  end

  test "Test the day 8 puzzle 2 against the example file" do
    assert Day8.puzzle2("test/testfiles/day8_test3.txt") == 6
  end
end
