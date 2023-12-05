defmodule Day3 do
  @moduledoc """
  Module that will contain the answers
  for the day 3 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 3 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    to_charlist(contents)
    |> parse_input
    |> verify_connection
    |> Enum.sum
  end

  @spec parse_input(charlist()) :: {list(), list()}
  def parse_input(input) do
    parse_input(input, {[],[]}, 0)
  end
  def parse_input([], {acc_numbers, acc_symbols}, _) do
    {Enum.filter(acc_numbers, fn(elem) -> elem !== [] end),
      Enum.filter(acc_symbols, fn(elem) -> elem !== [] end)}
  end
  def parse_input(input, {acc_numbers, acc_symbols}, row) do
    {numbers, symbols, tail} = parse_line(input, row)
    parse_input(tail, {acc_numbers ++ numbers, acc_symbols ++ symbols}, row + 1)
  end

  def parse_line(line, row) do
    parse_line(line, [], [], 0, row)
  end
  def parse_line([], numbers, symbols, _, _) do
    {numbers, symbols, []}
  end
  def parse_line([10|tail], numbers, symbols, _, _) do
    {numbers, symbols, tail}
  end
  def parse_line([46|tail], numbers, symbols, pos, row) do
    parse_line(tail, numbers, symbols, pos+1, row)
  end
  def parse_line(input, numbers, symbols, pos, row) when hd(input) in 48..57 do
    {f_input, actual, f_pos} = parse_symbol(input, pos)
    s_string = to_string(actual)
    case Integer.parse(s_string) do
      {number, ""} -> parse_line(f_input, numbers ++ [{number, {pos, f_pos-1}, row}], symbols, f_pos, row)
      _ -> parse_line(f_input, numbers, symbols ++ [{pos, row}], f_pos, row)
    end
  end
  def parse_line(input, numbers, symbols, pos, row) do
    {f_input, actual, f_pos} = parse_symbol(input, pos)
    parse_line(f_input, numbers, symbols ++ [{actual, {pos, row}}], f_pos+1, row)
  end

  @spec parse_symbol(list(), integer()) :: {list(), list(), integer()}
  def parse_symbol([curr|tail], pos) do
    {f_tail, actual, f_pos} = parse_symbol(curr, tail, [], pos)
    {f_tail, actual, f_pos}
  end
  def parse_symbol(46, tail , acc, pos) do
    {'.' ++ tail, acc, pos}
  end
  def parse_symbol(10, tail, acc, pos) do
    {'\n' ++ tail, acc, pos}
  end
  def parse_symbol(symbol, [next|tail], acc, pos) when symbol in 48..57 do
    case next in 48..57 do
      true -> parse_symbol(next, tail, acc ++ [symbol], pos+1)
      _ -> {[next|tail], acc ++ [symbol], pos+1}
    end
  end
  def parse_symbol(symbol, tail, acc, pos) do
    {tail, acc ++ [symbol], pos}
  end

  def verify_connection({numbers, symbols}) do
    Enum.filter(numbers, fn(number) -> check_symbols(number, symbols) !== [] end)
    |> Enum.map(fn({number, _, _}) -> number end)
  end

  def check_symbols({_, {min, max}, row}, symbols) do
    Enum.filter(symbols,
      fn({_, {s_col, s_row}}) ->
        dif_min = min - s_col < 2
        dif_max = s_col - max < 2
        in_row = s_row - row in [-1, 0 ,1]
        dif_min and dif_max and in_row
      end)
  end



  @doc """
  Solution for Day 3 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    to_charlist(contents)
    |> parse_input
    |> gear_connection
    |> Enum.sum
  end

  def gear_connection({numbers, symbols}) do
    Enum.filter(symbols, fn({symbol, _}) -> symbol === '*' end)
    |> Enum.map(fn(gear) -> check_numbers(numbers, gear) end)
    |> Enum.filter(fn(numbers) -> length(numbers) === 2 end)
    |> Enum.map(fn([num1, num2]) -> num1 * num2 end)
  end

  def check_numbers(numbers, gear) do
    Enum.filter(numbers, fn(number) -> check_gears(number, gear) end)
    |> Enum.map(fn({number, _, _}) -> number end)
  end

  def check_gears({_, {min, max}, row}, {_, {s_col, s_row}}) do
    dif_min = min - s_col < 2
    dif_max = s_col - max < 2
    in_row = s_row - row in [-1, 0 ,1]
    dif_min and dif_max and in_row
  end
end
