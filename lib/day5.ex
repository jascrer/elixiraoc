defmodule Day5 do
  @moduledoc """
  Module that will contain the answers
  for the day 5 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 5 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_maps(contents)
    |> get_locations()
  end

  def parse_maps(input) do
    [seeds | maps] = String.split(input, "\n\n")
    n_seeds = String.slice(seeds, 7, String.length(seeds))
      |> String.split(" ")
      |> Enum.map(fn(seed) -> {number, ""} = Integer.parse(seed); number end)
    n_maps = Enum.map(maps,
      fn(map) ->
        String.split(map, "\n")
        |> tl
        |> convert_to_tuples end)
    {n_seeds, n_maps}
  end

  def convert_to_tuples(ranges) do
    Enum.map(ranges,
      fn(range) ->
        [de, so, le] = String.split(range, " ")
        |> Enum.map(
            fn(index) ->
              {number, ""} = Integer.parse(index); number
            end); {so, de, le}
      end)
  end

  def get_locations({seeds, maps}) do
    Enum.map(seeds, & seed_maps(&1, maps))
    |> Enum.min
  end

  def seed_maps(seed, []), do: seed
  def seed_maps(seed, [map | maps]) do
    n_seed = seed_map(seed, map)
    seed_maps(n_seed, maps)
  end

  def seed_map(seed, []), do: seed
  def seed_map(seed, [{s, d, l} | t]) do
    case seed >= s and seed <= (s + (l-1)) do
      true -> (seed - s) + d
      _ -> seed_map(seed, t)
    end
  end

  @doc """
  Solution for Day 5 Puzzle 2
  """
  @spec puzzle2(String.t()) :: {list(), list()}
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_maps(contents)
    |> range_seeds
  end

  def range_seeds({seeds, maps}) do
    n_seeds = create_ranges(seeds, [])
    {n_seeds, maps}
  end

  def create_ranges([], acc), do: acc
  def create_ranges([seeds, length | tail], acc), do: create_ranges(tail, acc ++ [{seeds, seeds + length - 1}])

end
