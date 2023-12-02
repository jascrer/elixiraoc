defmodule Day1_test do
  use ExUnit.Case
  doctest Day1

  test "Test the day 1 puzzle 1 against the example file" do
    assert Day1.puzzle1("test/testfiles/day1_test.txt") == 142
  end

  test "Evaluation agains input for puzzle 1" do
    assert Day1.puzzle1("test/testfiles/day1_input.txt") == 55712
  end

  test "Test the day 1 puzzle 2 agains example file" do
    assert Day1.puzzle2("test/testfiles/day1_test2.txt") == 281
  end

  test "Evaluation agains input for puzzle2" do
    assert Day1.puzzle2("test/testfiles/day1_input.txt") == 55413
  end
end
