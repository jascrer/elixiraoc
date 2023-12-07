defmodule Day6 do
  @moduledoc """
  Module that will contain the answers
  for the day 6 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 6 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_times(contents)
    |> get_pairs([])
    |> Enum.product()
  end

  @spec parse_times(Strin.t()) :: [{integer(), integer()}]
  def parse_times(input) do
    [times, distances] = String.split(input, "\n")
    p_times = clean_inputs(times)
    p_distances = clean_inputs(distances)
    Enum.zip(p_times, p_distances)
  end

  @spec clean_inputs(String.t()) :: list()
  def clean_inputs(input) do
    String.split(input, " ")
    |> tl
    |> Enum.filter(fn(input) -> input !== "" end)
    |> Enum.map(fn(elem) -> {number, ""} = Integer.parse(elem); number end)
  end

  def get_pairs([], acc) do
    acc
  end
  def get_pairs([{time, distance} | tail], acc) do
    pairs = Enum.map(Enum.to_list(2..trunc(time / 2)), fn(ms) -> {ms, (time - ms)} end)
      |> Enum.filter(fn({p1, p2}) -> (p1 * p2) > distance end)
      |> length
    case rem(time,2) == 0  do
      true -> get_pairs(tail, acc ++ [(pairs * 2) - 1])
      _ -> get_pairs(tail, acc ++ [pairs * 2])
    end
  end

  @doc """
  Solution for Day 6 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_time(contents)
    |> get_pairs([])
    |> Enum.product()
  end

  @spec parse_time(Strin.t()) :: [{integer(), integer()}]
  def parse_time(input) do
    [times, distances] = String.split(input, "\n")
    [{clean_input(times), clean_input(distances)}]
  end

  @spec clean_input(String.t()) :: integer()
  def clean_input(input) do
    s_number = Regex.scan(~r/[0-9]/, input)
    |> List.foldr("", fn([digit], acc) -> digit <> acc end)
    {number, ""} = Integer.parse(s_number)
    number
  end
end
