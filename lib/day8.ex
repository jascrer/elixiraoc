defmodule Day8 do
  @moduledoc """
  Module that will contain the answers
  for the day 0 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 8 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_map(contents)
    |> navigate()
  end

  @spec parse_map(String.t()) :: {list(), map(), String.t()}
  def parse_map(input) do
    [instr, map] = String.split(input,"\n\n")
    n_map = String.split(map, "\n") |> Enum.map(& parse_nodes(&1))
    {String.graphemes(instr), n_map |> Map.new, "AAA"}
  end

  defp parse_nodes(node) do
    [source, left, right] = Regex.scan(~r/[0-9A-Z][0-9A-Z][0-9A-Z]/, node)
    |> Enum.map(fn([p_node]) -> p_node end)
    {source, {left, right}}
  end

  def navigate(pair), do: navigate(pair, 0)
  def navigate({instr, map, entry}, counter) do
    {n_counter, symbol} = navigate(instr, map, entry, counter)
    cond do
      String.ends_with?(symbol, "Z") -> n_counter
      true -> navigate({instr, map, symbol}, n_counter)
    end
  end
  def navigate([], _map, entry, counter), do: {counter, entry}
  def navigate([inst|tail], map, entry, counter) do
    {left, right} = Map.fetch!(map, entry)
    case inst do
      "L" -> navigate(tail, map, left, counter + 1)
      _ -> navigate(tail, map, right, counter + 1)
    end
  end

  @doc """
  Solution for Day 8 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_map2(contents)
    |> navigate2()
  end

  @spec parse_map2(String.t()) :: {list(), map(), list()}
  def parse_map2(input) do
    [instr, map] = String.split(input,"\n\n")
    n_map = String.split(map, "\n") |> Enum.map(& parse_nodes(&1)) |> Map.new
    {String.graphemes(instr), n_map, Map.keys(n_map) |> Enum.filter(& String.ends_with?(&1, "A"))}
  end

  # Using LCM to calculate the final result
  def navigate2({instr, map, nodes}) do
    Enum.map(nodes,& navigate({instr, map, &1}))
    |> List.foldr(1, fn(counter, acc) -> Math.lcm(acc, counter) end)
  end

end
