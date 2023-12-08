defmodule Day9_test do
  use ExUnit.Case
  doctest Day9

  test "Test the day 9 puzzle 1 against the example file" do
    assert Day9.puzzle1("test/testfiles/day9_test.txt") == 114
  end

  test "Get new results" do
    seq = [0, 3, 6, 9, 12, 15]
    assert Day9.new_sequence(seq, []) === [3, 3, 3, 3, 3]
  end

  test "Get all sequences" do
    seq = [0, 3, 6, 9, 12, 15]
    assert Day9.get_sequence(seq)  === [[0, 0, 0, 0], [3, 3, 3, 3, 3], [0, 3, 6, 9, 12, 15]]
  end


  test "Test the day 9 puzzle 2 against the example file" do
    assert Day9.puzzle2("test/testfiles/day9_test.txt") == 2
  end
end
