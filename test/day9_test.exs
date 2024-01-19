defmodule Day9_test do
  use ExUnit.Case
  doctest Day9

  test "Get new results" do
    seq = [0, 3, 6, 9, 12, 15]
    assert Day9.new_sequence(seq, []) === [3, 3, 3, 3, 3]
  end

  test "Get all sequences" do
    seq = [0, 3, 6, 9, 12, 15]
    assert Day9.get_sequence(seq)  === [[0, 0, 0, 0], [3, 3, 3, 3, 3], [0, 3, 6, 9, 12, 15]]
  end
end
