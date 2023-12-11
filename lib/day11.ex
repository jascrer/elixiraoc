defmodule Day11 do
  @moduledoc """
  Module that will contain the answers
  for the day 11 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 11 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_galaxies(contents)
    |> get_distances([])
    |> Enum.sum
  end

  def parse_galaxies(input) do
    String.split(input, "\n")
    |> Enum.map(
      fn(space) ->
        String.graphemes(space)
      end)
    |> expand_space()
    |> Enum.map(
      fn(space) ->
        Enum.with_index(space)
        |> Enum.filter(fn({point, _}) -> point === "#" end)
      end)
    |> Enum.with_index()
    |> Enum.filter(fn({list, _}) -> list !== [] end)
    |> Enum.map(fn({galaxies, row})-> Enum.map(galaxies, fn({_, col})-> {row, col} end) end)
    |> List.flatten
  end

  def expand_space(map) do
    expand(map, [])
    |> transpose()
    |> expand([])
    |> transpose()
  end

  def expand([], acc) do
    acc
  end
  def expand([head|tail], acc) do
    cond do
      Enum.filter(head, fn(sim) -> sim !== "." end) |> length == 0 -> expand(tail, acc ++ [head] ++ [head])
      true-> expand(tail, acc ++ [head])
    end
  end

  def transpose([]), do: []
  def transpose([[] | xss]), do: transpose(xss)
  def transpose([[x | xs] | xss]) do
    [[x | (for [h | _t] <- xss, do: h)] | transpose([xs | (for [_h | t] <- xss, do: t)])]
  end

  def get_distances([], acc) do
    acc
  end
  def get_distances([head | tail], acc) do
    get_distances(tail, get_distances(head, tail, acc))
  end
  def get_distances(_, [], acc) do
    acc
  end
  def get_distances({x1, y1}, [{x2, y2} | tail], acc) do
    diff_x = abs(x1 - x2)
    diff_y = abs(y1 - y2)
    get_distances({x1,y1}, tail, acc ++ [diff_x + diff_y])
  end

  @doc """
  Solution for Day 11 Puzzle 2
  """
  @spec puzzle2(String.t(), integer()) :: any()
  def puzzle2(fileName, factor) do
    {:ok, contents} = File.read(fileName)
    sum_orig = parse_galaxies2(contents)
    |> get_distances([])
    |> Enum.sum
    sum_expan = parse_galaxies(contents)
    |> get_distances([])
    |> Enum.sum
    sum_orig + ((sum_expan - sum_orig) * (factor-1))
  end

  def parse_galaxies2(input) do
    String.split(input, "\n")
    |> Enum.map(
      fn(space) ->
        String.graphemes(space)
      end)
    |> Enum.map(
      fn(space) ->
        Enum.with_index(space)
        |> Enum.filter(fn({point, _}) -> point === "#" end)
      end)
    |> Enum.with_index()
    |> Enum.filter(fn({list, _}) -> list !== [] end)
    |> Enum.map(fn({galaxies, row})-> Enum.map(galaxies, fn({_, col})-> {row, col} end) end)
    |> List.flatten
  end
end
