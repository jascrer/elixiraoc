defmodule Day12 do
  @moduledoc """
  Module that will contain the answers
  for the day 12 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 12 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_springs(contents)
  end

  def parse_springs(input) do
    input
    |> String.split("\n")
    |> Enum.map(
      fn(row) ->
        row
        |> String.split(" ")
        |> List.to_tuple
        |> Kernel.then(fn({symbols, numbers}) -> {clean_symbols(symbols), format_numbers(numbers)} end)
      end)
  end

  defp clean_symbols(symbols) do
    symbols
    |> String.split(".")
    |> Enum.filter(fn(str) -> str !== "" end)
    |> Enum.join(".")
  end

  defp format_numbers(numbers) do
    numbers
    |> String.split(",")
    |> Enum.map(fn(num) -> {n, ""} = Integer.parse(num); n end)
  end


  # def format_row(row) do
  #   {symbols, numbers} =  String.split(" ")
  # end


  @doc """
  Solution for Day 12 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
  end
end
