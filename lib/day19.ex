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
  end

  @doc """
  Solution for Day 19 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
  end
end
