defmodule Day19 do
  @moduledoc """
  Template file for the Puzzles of Advent of Code 2023
  Module that will contain the answers
  for the day 19 of Advent of Code 2023.
  """

  defmodule Day19.Parser do
    import NimbleParsec

    condition =
      ascii_string([?a..?z], min: 1)
      |> choice([string(">"), string("<")])
      |> integer(min: 1)
      |> ignore(string(":"))
      |> choice([ascii_string([?a..?z], min: 1), ascii_string([?A, ?R], min: 1)])

    row =
      choice([condition, ascii_string([?a..?z], min: 1), ascii_string([?A, ?R], min: 1)])
      |> post_traverse({:to_tuple, []})
      |> choice([ignore(string(",")), ignore(string("}"))])
      |> times(min: 1)

    instr =
      ascii_string([?a..?z], min: 1)
      |> ignore(string("{"))
      |> concat(row)
      |> reduce({:to_pair2, []})

    instrs =
      instr
      |> ignore(string("\n"))
      |> times(min: 1)

    values =
      ascii_string([?a..?z], min: 1)
      |> ignore(string("="))
      |> integer(min: 1)
      |> reduce({:to_pair_data, []})
      |> choice([ignore(string(",")), ignore(string("}"))])
      |> times(min: 1)
      |> reduce({Map, :new, []})

    data =
      ignore(string("{"))
      |> concat(values)
      |> optional(ignore(string("\n")))
      |> times(min: 1)

    defp to_tuple(rest, args, context, _, _), do: {rest, [args |> Enum.reverse |> List.to_tuple], context}

    defp to_pair2([conditions | rest]), do: {conditions, rest}

    defp to_pair_data([conditions | rest]), do: {conditions, rest |> hd}

    defparsec(:map,
      instrs
      |> reduce({Map, :new, []})
      |> ignore(string("\n"))
      |> wrap(data)
    )
  end

  @doc """
  Solution for Day 19 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
    |> Day19.Parser.map
    |> process_instr
  end

  @spec process_instr({atom(), [...], String.t(), map(), {integer(), integer()}, integer()}) :: integer()
  def process_instr({_, [map, instrs], "", _, _, _}) do
    instrs
    |> List.foldl([], & [navigate_map("in", map, &1) | &2])
    |> Enum.filter(& &1 !== "R")
    |> Enum.map(& &1 |> Map.values() |> Enum.sum)
    |> Enum.sum
  end

  @spec navigate_map(String.t(), map(), map()) :: String.t()
  def navigate_map(key, map, head) do
    case navigate_key(Map.fetch!(map, key), head) do
      "A" -> head
      "R" -> "R"
      value -> navigate_map(value, map, head)
    end
  end

  @spec navigate_key([{String.t(), String.t(), integer(), String.t()} | {String.t}], map()) :: String.t()
  def navigate_key(ind, _data) when length(ind) == 1 do
    {value} = hd(ind); value
  end
  def navigate_key([{variable, comparison, quantity, result} | tail], data) do
    case Map.fetch(data, variable) do
      {:ok, value} ->
        cond do
          satisfies?(comparison, value, quantity) -> result
          true -> navigate_key(tail, data)
        end
      :error -> navigate_key(tail, data)
    end
  end

  defp satisfies?(">", value1, value2), do: value1 > value2
  defp satisfies?("<", value1, value2), do: value1 < value2



  @doc """
  Solution for Day 19 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
    |> Day19.Parser.map
    |> create_tree()
  end

  @spec create_tree({atom(), [...], String.t(), map(), {integer(), integer()}, integer()}) :: integer()
  def create_tree({_, [map, _], "", _, _, _}) do
    map
  end
end
