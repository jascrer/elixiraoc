defmodule Day5_test do
  use ExUnit.Case
  doctest Day5

  # test "Test the day 5 puzzle2 against the example file" do
  #   assert Day5.puzzle2("test/testfiles/day5_test.txt") == 46
  #   Day5.puzzle2("test/testfiles/day5_input.txt") |> IO.inspect()
  # end

  test "Seed convertion" do
    assert Day5.seed_map(79, [{98, 50, 2}, {50, 52, 48}]) === 81
    assert Day5.seed_map(14, [{98, 50, 2}, {50, 52, 48}]) === 14
    assert Day5.seed_map(55, [{98, 50, 2}, {50, 52, 48}]) === 57
    assert Day5.seed_map(13, [{98, 50, 2}, {50, 52, 48}]) === 13
  end

  test "Seed multi-convertion" do
    maps = [[{98, 50, 2}, {50, 52, 48}],
    [{15, 0, 37}, {52, 37, 2}, {0, 39, 15}],
    [{53, 49, 8}, {11, 0, 42}, {0, 42, 7}, {7, 57, 4}],
    [{18, 88, 7}, {25, 18, 70}],
    [{77, 45, 23}, {45, 81, 19}, {64, 68, 13}],
    [{69, 0, 1}, {0, 1, 69}],
    [{56, 60, 37}, {93, 56, 4}]]
    assert Day5.seed_maps(79, maps) === 82
    assert Day5.seed_maps(14, maps) === 43
    assert Day5.seed_maps(55, maps) === 86
    assert Day5.seed_maps(13, maps) === 35
  end


end
