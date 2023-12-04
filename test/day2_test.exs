defmodule Day2_test do
  use ExUnit.Case
  doctest Day2

  test "Test the day 2 puzzle 1 against the example file" do
    assert Day2.puzzle1("test/testfiles/day2_test.txt") == 8
  end

  test "Test the day 2 puzzle 2 against the example file" do
    assert Day2.puzzle2("test/testfiles/day2_test.txt") == 2286
  end

  test "Cubes can/not be inside the bag" do
    cube = Map.new([{:red, 1}, {:green, 2}, {:blue, 6}])
    cube2 = Map.new([{:red, 20}, {:green, 8}, {:blue, 6}])
    cube3 = Map.new([{:green, 2}])
    assert Day2.cube_satisfies(cube)
    assert Day2.cube_satisfies(cube3)
    assert Day2.cube_satisfies(cube2) == false
  end

  test "Subset is possible" do
    subset = [
      Map.new([{:red, 4}, {:blue, 3}]),
      Map.new([{:red, 1}, {:green, 2}, {:blue, 6}]),
      Map.new([{:green, 2}])]
    subset2 = [
      Map.new([{:red, 20}, {:green, 8}, {:blue, 6}]),
      Map.new([{:red, 4}, {:green, 13}, {:blue, 5}]),
      Map.new([{:red, 1}, {:green, 5}])]
    assert Day2.subset_satisfies(subset)
    assert Day2.subset_satisfies(subset2) == false
  end

  test "Max cube values comparison" do
    cube = Map.new([{:red, 0}, {:green, 0}, {:blue, 0}])
    cube2 = Map.new([{:red, 20}, {:green, 8}, {:blue, 6}])
    cube3 = Map.new([{:green, 2}])
    asserted_cube = Map.new([{:red, 0}, {:green, 2}, {:blue, 0}])
    assert Day2.cube_comparison(cube, cube3) == asserted_cube
    assert Day2.cube_comparison(asserted_cube, cube2) == cube2
  end

  test "Calculate subset powers" do
    subset = [
      Map.new([{:red, 4}, {:blue, 3}]),
      Map.new([{:red, 1}, {:green, 2}, {:blue, 6}]),
      Map.new([{:green, 2}])]
    subset2 = [
      Map.new([{:red, 20}, {:green, 8}, {:blue, 6}]),
      Map.new([{:red, 4}, {:green, 13}, {:blue, 5}]),
      Map.new([{:red, 1}, {:green, 5}])]
    assert Day2.subset_power(subset) == Map.new([{:red, 4}, {:green, 2}, {:blue, 6}])
    assert Day2.subset_power(subset2) == Map.new([{:red, 20}, {:green, 13}, {:blue, 6}])
  end
end
