defmodule Day3_test do
  use ExUnit.Case
  doctest Day3

  test "Test the day 3 Puzzle 1" do
    assert Day3.puzzle1("test/testfiles/day3_test.txt") == 4361
  end

  test "Test the day 3 Puzzle 2" do
    assert Day3.puzzle2("test/testfiles/day3_test.txt") == 467835
    Day3.puzzle2("test/testfiles/day3_input.txt") |> IO.puts
  end

  test "Parse one symbol" do
    line = '467..114..'
    line2 = '*.........'
    line3 = '617*......'
    assert Day3.parse_symbol(line, 0) == {'..114..', '467',3}
    assert Day3.parse_symbol(line2, 0) == {'.........', '*', 0}
    assert Day3.parse_symbol(line3, 0) == {'*......', '617', 3}
  end

  test "Parse one line" do
    line = '467..114..\n.'
    line2 = '...*......'
    line3 = '617*......'
    line4 = '.....+.58.'
    line5 = '...$.*....'
    assert Day3.parse_line(line, 0) == {[{467, {0, 2}, 0}, {114, {5, 7}, 0}], [], '.'}
    assert Day3.parse_line(line2, 0) == {[], [{'*', {3, 0}}], []}
    assert Day3.parse_line(line3, 0) == {[{617, {0,2}, 0}], [{'*', {3, 0}}], []}
    assert Day3.parse_line(line4, 0) == {[{58, {7,8}, 0}], [{'+',{5, 0}}], []}
    assert Day3.parse_line(line5, 0) == {[], [{'$',{3, 0}}, {'*',{5, 0}}], []}
  end

  test "Parse lines" do
    line = '467..114..\n...*......'
    assert Day3.parse_input(line) == {[{467, {0, 2}, 0}, {114, {5,7}, 0}], [{'*',{3, 1}}]}
  end
end
