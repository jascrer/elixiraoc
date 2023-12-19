defmodule Day15 do
  @moduledoc """
  Module that will contain the answers
  for the day 15 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 15 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_sequence(contents)
    |> Enum.map(& hash_input(&1))
    |> Enum.sum
  end

  defp parse_sequence(input), do: String.split(input, ",")

  @spec hash_input(String.t()) :: number()
  def hash_input(step) do
    step
    |> to_charlist
    |> List.foldl(0, fn(char, acc) -> rem((char + acc) * 17, 256) end)
  end

  @doc """
  Solution for Day 15 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_instructions(contents)
    |> execute_in_map(Map.new())
    |> Map.to_list()
    |> Enum.filter(fn({_, list}) -> list !== [] end)
    |> Enum.map(
      fn({box, list}) ->
        list
        |> Enum.map(fn([_code, focal]) -> {n_focal, ""} = Integer.parse(focal); n_focal end)
        |> Enum.with_index(1)
        |> Enum.map(fn({focal, slot}) -> (box + 1) *focal * slot end)
      end)
    |> List.flatten
    |> Enum.sum
  end

  defp parse_instructions(input) do
    String.split(input, ",")
    |> Enum.map(& parse_instr(&1))
  end

  defp parse_instr(step) do
    cond do
      String.graphemes(step) |> Enum.member?("=") -> splitted = String.split(step, "="); {:add, splitted, hash_input(hd(splitted))}
      String.graphemes(step) |> Enum.member?("-") -> splitted = String.split(step, "-"); {:remove, splitted, hash_input(hd(splitted))}
    end
  end

  @spec execute_in_map([{:add, [...], any()} | {:remove, [...], any()}], map()) :: map()
  def execute_in_map([], hashmap), do: hashmap
  def execute_in_map([{instr, data, box} | tail], hashmap) do
    case Map.fetch(hashmap, box) do
      {:ok, map} -> execute_in_map(tail, execute_inst(instr, data, hashmap, map, box))
      :error -> execute_in_map(tail, execute_inst(instr, data, hashmap, [], box))
    end
  end

  @spec execute_inst(:add | :remove, [...], map(), list(), number()) :: map()
  def execute_inst(:add, [label, lens], hashmap, map, box) do
    cond do
      Enum.filter(map, fn([lbl, _]) -> label === lbl end) |> length == 1 -> n_map = Enum.map(map, fn [lbl, len] -> if lbl == label, do: [label, lens], else: [lbl,len] end); Map.put(hashmap, box, n_map)
      true -> Map.put(hashmap, box, map ++ [[label, lens]])
    end
  end
  def execute_inst(:remove, [label, _], hashmap, map, box) do
    filtered = Enum.filter(map, fn([lbl, _]) -> label !== lbl end)
    Map.put(hashmap, box, filtered)
  end
end
