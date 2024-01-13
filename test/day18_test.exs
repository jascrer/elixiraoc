  defmodule Day18_test do
  use ExUnit.Case
  doctest Day18

  test "Test the day 18 puzzle 1 against the example file" do
    assert Day18.puzzle1("test/testfiles/day18_test.txt") == 62
  end

  test "Test the day 18 puzzle 2 against the example file" do
    # assert Day18.puzzle2("test/testfiles/day18_test.txt") == 62
    # Day18.puzzle2("test/testfiles/day18_test.txt") |> IO.inspect
  end
end
