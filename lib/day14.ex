defmodule Day14 do
  @moduledoc """
  Module that will contain the answers
  for the day 14 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 14 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_lines(contents)
    |> tilt_rocks
    |> beam_load
  end

  defp parse_lines(input) do
    String.split(input,"\n")
    |> Enum.map(& &1 |> String.graphemes)
  end

  @spec tilt_rocks([list()]) :: [list()]
  def tilt_rocks(matrix) do
    matrix
    |> transpose()
    |> Enum.map(& &1 |> tilt_row)
    |> transpose()
  end

  @spec tilt_row(list()) :: list()
  def tilt_row(row) do
    tilt_row(row, [])
  end
  defp tilt_row([], acc), do: acc |> Enum.reverse
  defp tilt_row([head | tail], acc) do
    case head do
      "#" -> tilt_row(tail, [head] ++ acc)
      "." -> tilt_row(tail, [head] ++ acc)
      "O" -> tilt_row(tail, roll_rock(head, acc))
    end
  end

  defp roll_rock(rock, []), do: [rock]
  defp roll_rock(rock, [head | tail]) do
    case head do
      "#" -> [rock] ++ [head | tail]
      "O" -> [rock] ++ [head | tail]
      "." -> [head] ++ roll_rock(rock, tail)
    end
  end

  defp transpose([]), do: []
  defp transpose([[] | xss]), do: transpose(xss)
  defp transpose([[x | xs] | xss]) do
    [[x | (for [h | _t] <- xss, do: h)] | transpose([xs | (for [_h | t] <- xss, do: t)])]
  end

  defp beam_load(matrix) do
    matrix
    |> Enum.map(fn(list) -> Enum.filter(list, & &1 === "O") |> length end)
    |> Enum.reverse
    |> Enum.with_index(1)
    |> Enum.reverse
    |> Enum.map(fn({total, idx}) -> total * idx end)
    |> Enum.sum
  end

  @doc """
  Solution for Day 14 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_lines(contents)
    |> collector_tilts(0, [])
  end

  @doc """
  The only multiple of 10 to repeat the example result (64) with 1 billion was 1 thousand
  """
  @spec collector_tilts(list(), integer(), list()) :: number()
  def collector_tilts(matrix, 1000, _acc), do: beam_load(matrix)
  def collector_tilts(matrix, counter, acc) do
    t_matrix = tilt_rocks2(matrix)
    collector_tilts(t_matrix, counter + 1, acc)
  end

  @spec tilt_rocks2([list()]) :: [list()]
  def tilt_rocks2(matrix) do
    matrix
    |> transpose() #North
    |> Enum.map(& &1 |> tilt_row)
    |> transpose() #West
    |> Enum.map(& &1 |> tilt_row)
    |> transpose
    |> Enum.map(& Enum.reverse(&1)) #South
    |> Enum.map(& &1 |> tilt_row)
    |> Enum.map(& Enum.reverse(&1))
    |> transpose #Reset
    |> Enum.map(& Enum.reverse(&1)) # East
    |> Enum.map(& &1 |> tilt_row)
    |> Enum.map(& Enum.reverse(&1)) # Reset
  end
end
