defmodule Day10_test do
  use ExUnit.Case
  doctest Day10

  # test "Test the day 10 puzzle 1 against the example file" do
  #   # assert Day10.puzzle1("test/testfiles/day10_test.txt") == ""
  #   Day10.puzzle1("test/testfiles/day10_test.txt") |> IO.inspect()
  #   "test/testfiles/day10_test.txt" |> Input.to_array
  # end

  # test "get symbol from the map" do
  #   map = [
  #     {[".", ".", ".", ".", "."], 0},
  #     {[".", "S", "-", "7", "."], 1},
  #     {[".", "|", ".", "|", "."], 2},
  #     {[".", "L", "-", "J", "."], 3},
  #     {[".", ".", ".", ".", "."], 4}
  #   ]
  #   assert Day10.get_symbol(map, {1,1}) == "S"
  #   assert Day10.get_symbol(map, {1,2}) == "-"
  #   assert Day10.get_symbol(map, {2,1}) == "|"
  # end
end
