defmodule CompletedDays_test do
  use ExUnit.Case

  test "Test the day 1 puzzle 1 against the example file" do
    assert Day1.puzzle1("test/testfiles/day1_test.txt") == 142
  end

  test "Test the day 1 puzzle 2 agains example file" do
    assert Day1.puzzle2("test/testfiles/day1_test2.txt") == 281
  end

  test "Test the day 2 puzzle 1 against the example file" do
    assert Day2.puzzle1("test/testfiles/day2_test.txt") == 8
  end

  test "Test the day 2 puzzle 2 against the example file" do
    assert Day2.puzzle2("test/testfiles/day2_test.txt") == 2286
  end

  test "Test the day 3 Puzzle 1" do
    assert Day3.puzzle1("test/testfiles/day3_test.txt") == 4361
  end

  test "Test the day 3 Puzzle 2" do
    assert Day3.puzzle2("test/testfiles/day3_test.txt") == 467835
  end

  test "Test the day 4 puzzle 1 against the example file" do
    assert Day4.puzzle1("test/testfiles/day4_test.txt") == 13
  end

  test "Test the day 4 puzzle 2 against the example file" do
    assert Day4.puzzle2("test/testfiles/day4_test.txt") == 30
  end

  test "Test the day 5 puzzle1 against the example file" do
    assert Day5.puzzle1("test/testfiles/day5_test.txt") == 35
  end

  test "Test the day 6 puzzle 1 against the example file" do
    assert Day6.puzzle1("test/testfiles/day6_test.txt") == 288
  end

  test "Test the day 6 puzzle 2 against the example file" do
    assert Day6.puzzle2("test/testfiles/day6_test.txt") == 71503
    assert Day6.puzzle2_math("test/testfiles/day6_test.txt") == 71503
  end

  test "Test the day 7 puzzle 1 against the example file" do
    assert Day7.puzzle1("test/testfiles/day7_test.txt") == 6440
  end

  test "Test the day 7 puzzle 2 against the example file" do
    assert Day7.puzzle2("test/testfiles/day7_test.txt") == 5905
  end

  test "Test the day 8 puzzle 1 against the example file" do
    assert Day8.puzzle1("test/testfiles/day8_test1.txt") == 2
    assert Day8.puzzle1("test/testfiles/day8_test2.txt") == 6
  end

  test "Test the day 8 puzzle 2 against the example file" do
    assert Day8.puzzle2("test/testfiles/day8_test3.txt") == 6
  end

  test "Test the day 9 puzzle 1 against the example file" do
    assert Day9.puzzle1("test/testfiles/day9_test.txt") == 114
  end

  test "Test the day 9 puzzle 2 against the example file" do
    assert Day9.puzzle2("test/testfiles/day9_test.txt") == 2
  end

  test "Test the day 10 puzzle 1 against the example file" do
    assert Day10.puzzle1("test/testfiles/day10_test.txt") == 4.0
    assert Day10.puzzle1("test/testfiles/day10_test2.txt") == 8.0
  end
  test "Test the day 10 puzzle 2 against the example file" do
    assert Day10.puzzle2("test/testfiles/day10_test3.txt") == 8
  end

  test "Test the day 11 puzzle 1 against the example file" do
    assert Day11.puzzle1("test/testfiles/day11_test.txt") == 374
  end

  test "Test the day 11 puzzle 2 against the example file" do
    assert Day11.puzzle2("test/testfiles/day11_test.txt", 10) == 1030
    assert Day11.puzzle2("test/testfiles/day11_test.txt", 100) == 8410
  end

  test "Test the day 13 puzzle 1 against the example file" do
    assert Day13.puzzle1("test/testfiles/day13_test.txt") == 405
  end

  test "Test the day 14 puzzle 1 against the example file" do
    assert Day14.puzzle1("test/testfiles/day14_test.txt") == 136
  end

  test "Test the day 14 puzzle 2 against the example file" do
    assert Day14.puzzle2("test/testfiles/day14_test.txt") == 64
  end

  test "Test the day 15 puzzle 1 against the example file" do
    assert Day15.puzzle1("test/testfiles/day15_test.txt") == 1320
  end

  test "Test the day 15 puzzle 2 against the example file" do
    assert Day15.puzzle2("test/testfiles/day15_test.txt") == 145
  end

  test "Test the day 16 puzzle 1 against the example file" do
    assert Day16.puzzle1("test/testfiles/day16_test.txt") == 46
  end

  test "Test the day 16 puzzle 2 against the example file" do
    assert Day16.puzzle2("test/testfiles/day16_test.txt") == 51
  end

  test "Test the day 18 puzzle 1 against the example file" do
    assert Day18.puzzle1("test/testfiles/day18_test.txt") == 62
  end
end
