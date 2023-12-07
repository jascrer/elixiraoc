defmodule Day6_test do
  use ExUnit.Case
  doctest Day6

  test "Test the day 6 puzzle 1 against the example file" do
    assert Day6.puzzle1("test/testfiles/day6_test.txt") == 288
  end

  test "Test the day 6 puzzle 2 against the example file" do
    assert Day6.puzzle2("test/testfiles/day6_test.txt") == 71503
    assert Day6.puzzle2_math("test/testfiles/day6_test.txt") == 71503
  end
end
