defmodule Day17 do
  @moduledoc """
  Module that will contain the answers
  for the day 17 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 17 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_map(contents)
    |> navigate(0, 0, 0)
  end

  defp parse_map(input) do
    input
    |> String.split("\n")
    |> Enum.map(& &1 |> String.graphemes |> Enum.map(fn(hl) -> {n_hl, ""} = Integer.parse(hl); n_hl end))
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Map.new
  end

  def navigate(map, row, col, steps) do
    row_count = map |> Map.keys |> length()
    col_count = map |> Map.fetch!(0) |> length()
    navigate(map, row, col, steps, row_count, col_count, :none)
  end
  defp navigate(map, row, col, _steps, _row_count, _col_count, :none) do
    r_point = map |> Map.fetch!(row) |> Enum.at(col + 1)
    s_point = map |> Map.fetch!(row + 1) |> Enum.at(col)
    {r_point, s_point}
  end
  @doc """
  Solution for Day 17 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
  end
end
