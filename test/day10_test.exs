defmodule Day10_test do
  use ExUnit.Case
  doctest Day10

  test "Navigate maps" do
    map_1 = [
      [".", ".", ".", ".", "."],
      [".", "S", "-", "7", "."],
      [".", "|", ".", "|", "."],
      [".", "L", "-", "J", "."],
      [".", ".", ".", ".", "."]
    ]
    map_2 = [
      ["-", "L", "|", "F", "7"],
      ["7", "S", "-", "7", "|"],
      ["L", "|", ".", "|", "|"],
      ["-", "L", "-", "J", "|"],
      ["L", "|", "-", "J", "F"]
    ]
    solution_1 = {:ok,
    [
      {:right, 1, 2},
      {:right, 1, 3},
      {:down, 2, 3},
      {:down, 3, 3},
      {:left, 3, 2},
      {:left, 3, 1},
      {:up, 2, 1},
      {:up, 1, 1}
    ]}
    map_3 = [
      [".", ".", "F", "7", "."],
      [".", "F", "J", "|", "."],
      ["S", "J", ".", "L", "7"],
      ["|", "F", "-", "-", "J"],
      ["L", "J", ".", ".", "."]
    ]
    map_4 = [
      ["7", "-", "F", "7", "-"],
      [".", "F", "J", "|", "7"],
      ["S", "J", "L", "L", "7"],
      ["|", "F", "-", "-", "J"],
      ["L", "J", ".", "L", "J"]
    ]
    solution_2 = {:ok,
    [
      {:right, 2, 1},
      {:up, 1, 1},
      {:right, 1, 2},
      {:up, 0, 2},
      {:right, 0, 3},
      {:down, 1, 3},
      {:down, 2, 3},
      {:right, 2, 4},
      {:down, 3, 4},
      {:left, 3, 3},
      {:left, 3, 2},
      {:left, 3, 1},
      {:down, 4, 1},
      {:left, 4, 0},
      {:up, 3, 0},
      {:up, 2, 0}
    ]}
    assert Day10.navigate_paths(map_1, {1, 1}, :right) == solution_1
    assert Day10.navigate_paths(map_2, {1, 1}, :right) == solution_1
    assert Day10.navigate_paths(map_3, {2, 0}, :right) == solution_2
    assert Day10.navigate_paths(map_4, {2, 0}, :right) == solution_2
  end


  test "Shoelace" do
    list = [{2,1}, {5,0}, {6,4}, {4,2}, {1,3}]
    assert Day10.shoelace(list)  == 8.0
  end
end
