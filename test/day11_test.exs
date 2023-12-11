defmodule Day11_test do
  use ExUnit.Case
  doctest Day11

  test "Test the day 11 puzzle 1 against the example file" do
    assert Day11.puzzle1("test/testfiles/day11_test.txt") == 374
  end

  test "Test the day 11 puzzle 2 against the example file" do
    assert Day11.puzzle2("test/testfiles/day11_test.txt", 10) == 1030
    assert Day11.puzzle2("test/testfiles/day11_test.txt", 100) == 8410
  end
end
