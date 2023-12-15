defmodule Day9 do
  @moduledoc """
  Module that will contain the answers
  for the day 9 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 9 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_series(contents)
    |> Enum.map(& get_sequence(&1) |> Enum.map(fn(t) -> List.last(t) end) |> Enum.sum)
    |> Enum.sum
  end

  @spec parse_series(String.t()) :: list()
  def parse_series(input) do
    String.split(input, "\n")
    |> Enum.map(& String.split(&1, " ") |> Enum.map(fn(num) -> {p_num, ""} = Integer.parse(num); p_num end))
  end

  def get_sequence(serie) do
    get_sequence(serie, [serie])
  end
  def get_sequence(serie, acc) do
    n_seq = new_sequence(serie, [])
    cond do
      Enum.filter(n_seq, & &1 !== 0) |> length === 0 -> Enum.reverse(acc ++ [n_seq])
      true -> get_sequence(n_seq, acc ++ [n_seq])
    end
  end

  @spec new_sequence(list(), list()) :: list()
  def new_sequence(seq, acc) when length(seq) == 1, do: acc
  def new_sequence([first, second | tail], acc), do: new_sequence([second | tail], acc ++ [second - first])

  @doc """
  Solution for Day 9 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_series(contents)
    |> Enum.map(& Enum.reverse(&1) |> get_sequence() |> Enum.map(fn(t) -> List.last(t) end) |> Enum.sum)
    |> Enum.sum
  end


end
