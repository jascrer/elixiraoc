defmodule Day18 do
  @moduledoc """
  Template file for the Puzzles of Advent of Code 2023
  Module that will contain the answers
  for the day 18 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 18 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
    |> parse_instr()
    |> calculate_points()
    |> cube_meters
  end

  defp parse_instr(instr) do
    instr
    |> String.split("\n")
    |> Enum.map(fn(ins) -> [dir, quantity, _] = String.split(ins, " "); {q, ""} = Integer.parse(quantity); {dir, q} end)
  end

  defp cube_meters(points) do
    Day10.picks_theorem(points) + (length(points) - 1)
  end

  defp calculate_points(instr), do: calculate_points(instr, {0,0}, [{0,0}])
  defp calculate_points([], _, points), do: points
  defp calculate_points([instr | tail], actual, points) do
    {n_actual, n_points} = execute_instr(instr, actual, points)
    calculate_points(tail, n_actual, n_points)
  end

  defp execute_instr({_dir, 0}, actual, points), do: {actual, points}
  defp execute_instr({dir, q}, actual, points) do
    n_actual = move(dir, actual)
    execute_instr({dir, q - 1}, n_actual, [n_actual | points])
  end

  defp move("R", {row, col}), do: {row, col + 1}
  defp move("D", {row, col}), do: {row + 1, col}
  defp move("L", {row, col}), do: {row, col - 1}
  defp move("U", {row, col}), do: {row - 1, col}

  @doc """
  Solution for Day 18 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
    |> parse_instr2()
    |> calculate_points()
    |> cube_meters
  end

  defp parse_instr2(instr) do
    instr
    |> String.split("\n")
    |> Enum.map(fn(ins) -> [_, _, instr] = String.split(ins, " "); convert_instr(instr) end)
  end

  def convert_instr(instr) do
    graph = instr |> String.graphemes
    {q, ""} = graph |> Enum.slice(2, 6) |> Enum.join() |> Integer.parse(16)
    case graph |> Enum.at(7) do
      "0" -> {"R", q}
      "1" -> {"D", q}
      "2" -> {"L", q}
      "3" -> {"U", q}
    end
  end
end
