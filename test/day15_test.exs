defmodule Day15_test do
  use ExUnit.Case
  doctest Day15

  test "Test the day 15 puzzle 1 against the example file" do
    assert Day15.puzzle1("test/testfiles/day15_test.txt") == 1320
  end

  test "Test the day 15 puzzle 2 against the example file" do
    assert Day15.puzzle2("test/testfiles/day15_test.txt") == 145
  end

  test "Hash string" do
    test_1 = "HASH"
    test_2 = "rn=1"
    assert Day15.hash_input(test_1) == 52
    assert Day15.hash_input(test_2) == 30
  end

  test "execute instr" do
    list = [
      {:add, ["rn", "1"], 0},
      {:remove, ["cm", ""], 0},
      {:add, ["qp", "3"], 1},
      {:add, ["cm", "2"], 0},
      {:remove, ["qp", ""], 1},
      {:add, ["pc", "4"], 3},
      {:add, ["ot", "9"], 3},
      {:add, ["ab", "5"], 3},
      {:remove, ["pc", ""], 3},
      {:add, ["pc", "6"], 3},
      {:add, ["ot", "7"], 3}
    ]
    map = %{
      0 => [["rn", "1"], ["cm", "2"]],
      1 => [],
      3 => [["ot", "7"], ["ab", "5"], ["pc", "6"]]
    }
    assert Day15.execute_in_map(list, Map.new()) === map
  end
end
