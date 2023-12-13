defmodule Day13_test do
  use ExUnit.Case
  doctest Day13

  test "Test the day 13 puzzle 1 against the example file" do
    assert Day13.puzzle1("test/testfiles/day13_test.txt") == 405
  end

  test "Test the day 13 puzzle 2 against the example file" do
    #assert Day13.puzzle2("test/testfiles/day13_test.txt") == 400
    Day13.puzzle2("test/testfiles/day13_input.txt") |> IO.inspect()
  end

  test "Index can propagate horizontal" do
    lines = [
      ["#", ".", ".", ".", "#", "#", ".", ".", "#"],
      ["#", ".", ".", ".", ".", "#", ".", ".", "#"],
      [".", ".", "#", "#", ".", ".", "#", "#", "#"],
      ["#", "#", "#", "#", "#", ".", "#", "#", "."],
      ["#", "#", "#", "#", "#", ".", "#", "#", "."],
      [".", ".", "#", "#", ".", ".", "#", "#", "#"],
      ["#", ".", ".", ".", ".", "#", ".", ".", "#"]
    ]
    lines2 = [
      ["#", ".", "#", "#", ".", ".", "#", "#", "."],
      [".", ".", "#", ".", "#", "#", ".", "#", "."],
      ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
      ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
      [".", ".", "#", ".", "#", "#", ".", "#", "."],
      [".", ".", "#", "#", ".", ".", "#", "#", "."],
      ["#", ".", "#", ".", "#", "#", ".", "#", "."]
    ]
    assert Day13.index_can_propagate(lines, {4,5})
    assert Day13.index_can_propagate(lines2, {3,4}) === false
    assert Day13.index_can_propagate(lines2 |> Day13.transpose, {5,6})
    assert Day13.index_can_propagate(lines |> Day13.transpose, {3,4}) === false
  end

  test "Index can propagate 2 horizontal" do
    lines = [
      ["#", ".", ".", ".", "#", "#", ".", ".", "#"],
      ["#", ".", ".", ".", ".", "#", ".", ".", "#"],
      [".", ".", "#", "#", ".", ".", "#", "#", "#"],
      ["#", "#", "#", "#", "#", ".", "#", "#", "."],
      ["#", "#", "#", "#", "#", ".", "#", "#", "."],
      [".", ".", "#", "#", ".", ".", "#", "#", "#"],
      ["#", ".", ".", ".", ".", "#", ".", ".", "#"]
    ]
    _lines2 = [
      ["#", ".", "#", "#", ".", ".", "#", "#", "."],
      [".", ".", "#", ".", "#", "#", ".", "#", "."],
      ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
      ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
      [".", ".", "#", ".", "#", "#", ".", "#", "."],
      [".", ".", "#", "#", ".", ".", "#", "#", "."],
      ["#", ".", "#", ".", "#", "#", ".", "#", "."]
    ]
    assert Day13.find_line_2(lines) === {1,2}
    #Day13.find_line_2(lines2) = {1,2} |> IO.inspect()
    #assert Day13.index_can_propagate2(lines, {4,5})
  end
end
