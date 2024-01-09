defmodule Day10 do
  @moduledoc """
  Module that will contain the answers
  for the day 10 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 10 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_map(contents)
    |> navigate_paths
    |> Enum.map(& path_length(&1))
    |> Enum.max
  end

  @spec parse_map(String.t()) :: [{list(), integer()}]
  def parse_map(input) do
    String.split(input, "\n")
    |> Enum.map(fn(rows) -> String.graphemes(rows) end)
  end

  def navigate_paths(map) do
    {cols, row} = map |> Enum.with_index |> Enum.filter(fn({row, _}) -> Enum.member?(row, "S") end) |> hd
    {_, col} = Enum.with_index(cols) |> Enum.filter(fn({symbol, _})-> symbol === "S" end) |> hd
    right_path = navigate_map(map, {row, col}, :right, [])
    up_path = navigate_map(map, {row, col}, :up, [])
    down_path = navigate_map(map, {row, col}, :down, [])
    left_path = navigate_map(map, {row, col}, :left, [])
    [right_path, up_path, down_path, left_path]
  end

  def navigate_paths(map, point, dir), do: navigate_map(map, point, dir, [])

  @spec navigate_map(any(), {integer(), integer()}, atom(), any()) ::
          {:error, :not_cycle} | {:ok, [...]}
  def navigate_map(map, {row,col}, dir, acc) do
    {n_dir, p_row, p_col} = navigate(dir, Enum.at(map, row) |> Enum.at(col))
    new_symbol = Enum.at(map, row + p_row) |> Enum.at(col + p_col)
    case {new_symbol, p_row, p_col} do
      {".", _, _} -> {:error, :not_cycle}
      {_, 0, 0} -> {:error, :not_cycle}
      {"S", _, _} -> {:ok, acc ++ [{n_dir, row + p_row, col + p_col}]}
      {_, _, _} -> navigate_map(map, {row + p_row, col + p_col}, n_dir, acc ++ [{n_dir, row + p_row, col + p_col}])
    end
  end

  @spec navigate(atom(), String.t()) :: {atom(), integer(), integer()}
  def navigate(:up, "|"), do: {:up, -1, 0}
  def navigate(:down, "|"), do: {:down, 1, 0}
  def navigate(:right, "-"), do: {:right, 0, 1}
  def navigate(:left, "-"), do: {:left, 0, -1}
  def navigate(:down, "L"), do: {:right, 0, 1}
  def navigate(:left, "L"), do: {:up, -1, 0}
  def navigate(:right, "J"), do: {:up, -1, 0}
  def navigate(:down, "J"), do: {:left, 0, -1}
  def navigate(:right, "7"), do: {:down, 1, 0}
  def navigate(:up, "7"), do: {:left, 0, -1}
  def navigate(:up, "F"), do: {:right, 0, 1}
  def navigate(:left, "F"), do: {:down, 1, 0}
  def navigate(:right, "S"), do: {:right, 0, 1}
  def navigate(:up, "S"), do: {:up, -1, 0}
  def navigate(:down, "S"), do: {:down, 1, 0}
  def navigate(:left, "S"), do: {:left, 0, -1}
  def navigate(atom, _symbol), do: {atom, 0, 0}

  @spec path_length({:error, :not_cycle} | {:ok, list()}) :: non_neg_integer()
  def path_length({:error, :not_cycle}), do: 0
  def path_length({:ok, cycle}), do: (cycle |> length) / 2

  @doc """
  Solution for Day 10 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
    |> parse_map
    |> navigate_paths
    |> Enum.sort(& path_length(&1) >= path_length(&2))
    |> hd
    |> clean_up
    |> picks_theorem()
  end

  def clean_up({_, points}), do: points |> Enum.map(fn({_, r, c}) -> {r, c} end)

  @spec shoelace(list()) :: float()
  def shoelace(list) do
    partial = shoelace(list, 0)
    {x2, y2} = list |> Enum.at(0)
    {x1, y1} = list |> Enum.at(length(list) - 1)
    (partial + ((x1*y2) - (y1*x2))) / 2
  end
  @spec shoelace(list(), number()) :: float()
  def shoelace(list, acc) when length(list) == 1, do: acc
  def shoelace([{x1, y1}, {x2, y2} | tail], acc), do: shoelace([{x2, y2} | tail], acc + ((x1*y2) - (y1*x2)))

  def picks_theorem(list), do: round(shoelace(list) - (length(list) / 2) + 1)

end
