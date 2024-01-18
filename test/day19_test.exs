defmodule Day19_test do
  use ExUnit.Case
  doctest Day19

  test "Test the day 19 puzzle 1 against the example file" do
    #assert Day19.puzzle1("test/testfiles/day19_test.txt") == ""
    Day19.puzzle1("test/testfiles/day19_test.txt") |> IO.inspect
  end
end
