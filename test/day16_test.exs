defmodule Day16_test do
  use ExUnit.Case
  doctest Day16

  test "Test the day 16 against the example file" do
    #assert Day16.puzzle1("test/testfiles/day16_test.txt") == 46
    Day16.puzzle1("test/testfiles/day16_input.txt") |> Day16.count_symbols |> IO.inspect
    File.write("test/testfiles/day16_output.txt", Day16.puzzle1("test/testfiles/day16_input.txt") |> Day16.stringify)

  end

  test "energize a cell" do
    cavern = [
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
    ]
    solution_1 = [
      ["#", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
    ]
    assert Day16.energize(cavern, 0, 0, ".") == solution_1
  end

  test "Is point traversed" do
    closed = [{0, 0, :right}, {0, 1, :right}, {0, 2, :right}, {1, 2, :down}]
    assert Day16.is_traversed(closed, {0, 2, :right})
    assert not Day16.is_traversed(closed, {0, 2, :down})
  end
end
