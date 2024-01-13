defmodule Day16 do
  @moduledoc """
  Template file for the Puzzles of Advent of Code 2023
  Module that will contain the answers
  for the day 16 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 16 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
    |> parse_cavern()
    |> energize_cavern()
    #|> count_symbols
    #|>stringify()
  end

  defp parse_cavern(cavern_map) do
    cavern_map
    |> String.split("\n")
    |> Enum.map(& String.graphemes(&1))
  end

  @spec count_symbols(list()) :: integer()
  def count_symbols(cavern) do
    cavern
    |> List.foldl(0, & (Enum.filter(&1, fn(symbol) -> symbol !== "." end) |> length) + &2)
  end

  def stringify(cavern) do
    cavern
    |> List.foldl("", & &2 <> Enum.join(&1) <> "\n")
  end


  @spec energize_cavern([[binary()]]) :: integer()
  def energize_cavern(cavern_map) do
    cells = cavern_map |> Enum.map(& Enum.map(&1, fn(_) -> "." end))
    energize_cavern(cavern_map, cells, [{0,0, :right}], [])
  end
  defp energize_cavern(_, _cells, [], closed) do
    closed |> Enum.map(fn({row, col, _}) -> {row, col} end) |> MapSet.new() |> MapSet.to_list() |> length
  end
  defp energize_cavern(cavern_map, cells, [{:skip} | tail], closed), do: energize_cavern(cavern_map, cells, tail, closed)
  defp energize_cavern(cavern_map, cells, [{row, col, dir} | tail], closed) do
    cavern_symbol = cavern_map |> Enum.at(row) |> Enum.at(col)
    new_cells = energize(cells, row, col, cavern_symbol)
    case mirror(dir, cavern_symbol) do
      {dir1, dir2} -> energize_cavern(cavern_map, new_cells, tail ++ Enum.map([dir1, dir2], & check_continuity(cells, row, col, &1, closed)), closed ++ [{row, col, dir}])
      dir1 -> energize_cavern(cavern_map, new_cells, tail ++ Enum.map([dir1], & check_continuity(cells, row, col, &1, closed)), closed ++ [{row, col, dir}])
    end
  end

  defp check_continuity(cells, row, col, dir, traversed) do
    {n_row, n_col} = move(row, col, dir)
    col_length = cells |> Enum.at(row) |> length
    cond do
      n_row < 0 or n_col < 0 or n_row >= length(cells) or n_col >= col_length -> {:skip}
      (cells |> Enum.at(row) |> Enum.at(col)) == "#" and Enum.member?(traversed, {row, col, dir}) -> {:skip}
      true -> {n_row, n_col, dir}
    end
  end

  @spec energize([[String.t()]], integer(), integer(), binary()) :: [[String.t()]]
  def energize(cells, row, col, symbol) do
    prev_rows = cells |> Enum.slice(0, row)
    act_rows = energize_col(cells, row, col, symbol)
    next_rows = cells |> Enum.slice(row + 1, length(cells) - 1)
    prev_rows ++ [act_rows] ++ next_rows
  end

  defp energize_col(cells, row, col, symbol) do
    prev_elems = Enum.at(cells, row) |> Enum.slice(0, col)
    next_elems = Enum.at(cells, row) |> Enum.slice(col + 1, length(Enum.at(cells, row)) - 1 )
    case symbol do
      "." -> prev_elems ++ ["#"] ++ next_elems
      _ -> prev_elems ++ [symbol] ++ next_elems
    end
  end

  defp move(row, col, :up), do: {row - 1, col}
  defp move(row, col, :down), do: {row + 1, col}
  defp move(row, col, :right), do: {row, col + 1}
  defp move(row, col, :left), do: {row, col - 1}

  @spec mirror(atom(), String.t()) :: {atom(), atom()} | atom()
  def mirror(:right, "|"), do: {:up, :down}
  def mirror(:left, "|"), do: {:up, :down}
  def mirror(:up, "-"), do: {:right, :left}
  def mirror(:down, "-"), do: {:right, :left}
  def mirror(:right, "/"), do: :up
  def mirror(:up, "/"), do: :right
  def mirror(:left, "/"), do: :down
  def mirror(:down, "/"), do: :left
  def mirror(:right, "\\"), do: :down
  def mirror(:down, "\\"), do: :right
  def mirror(:up, "\\"), do: :left
  def mirror(:left, "\\"), do: :up
  def mirror(dir, _mirror), do: dir

  @doc """
  Solution for Day 16 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
  end
end
