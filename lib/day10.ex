defmodule Day10 do
  @moduledoc """
  Module that will contain the answers
  for the day 10 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 10 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_map(contents)
    #|> navigate_paths
  end

  @spec parse_map(String.t()) :: [{list(), integer()}]
  def parse_map(input) do
    String.split(input, "\n")
    |> Enum.map(fn(rows) -> String.graphemes(rows) end)
    |> Enum.with_index
  end

  def navigate_paths(map) do
    {cols, row} = Enum.filter(map, fn({row, _}) -> Enum.member?(row, "S") end) |> hd
    {_, col} = Enum.with_index(cols) |> Enum.filter(fn({symbol, _})-> symbol === "S" end) |> hd
    {map, {col, row}}
    #navigate_start(map, {row, col}, [])
  end

  # @spec navigate_start(list(), {integer(), integer()}, list()) :: any()
  # def navigate_start(map, {row, col}, acc) do
  #   navigate_start(map, {row, col}, {:none, :right}, acc)
  # end
  # def navigate_start(map, start, {:none, :right}, acc) do
  #   symbol = get_symbol(map, {row, col})
  #   case symbol do
  #     "|" -> navigate_start(map, )
  #   end
  # end

  @spec get_symbol(map(), {integer(), integer()}) :: any()
  def get_symbol(map, {row, col}) do
    {cols, _row} = Enum.filter(map, fn({_, p_row}) -> row === p_row end) |> hd
    {sym, _} = Enum.with_index(cols) |> Enum.filter(fn({_, p_col})-> col === p_col end) |> hd
    sym
  end

  @doc """
  Solution for Day 10 Puzzle 2
  """
  @spec puzzle2(String.t()) :: String.t()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
  end
end
