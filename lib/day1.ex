defmodule Day1 do
  @moduledoc """
  Module that will contain the answers
  for the day 1 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 1 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_lines(contents)
    |> List.foldr(0,
        fn(digits, acc) ->
          total = (hd(digits) * 10) + List.last(digits);
          acc + total
        end)
  end

  defp parse_lines(lines) do
    String.split(lines, "\n")
    |> Enum.map(fn(str) -> scan_convert(str) end)
  end

  defp scan_convert(str) do
    Regex.scan(~r/[0-9]/, str)
    |> Enum.map(fn(digit) -> {number, _} = Integer.parse(hd(digit)); number end)
  end

  @doc """
  Solution for Day 1 Puzzle 2
  """
  @spec puzzle2(String.t()) :: list()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_numbers(contents)
    |> List.foldr(0, fn(digits, acc) -> total = (hd(digits) * 10) + List.last(digits); total+acc end)
  end

  defp parse_numbers(lines) do
    String.split(lines, "\n")
    |> Enum.map(fn(str) -> scan_numbers(str) end)
  end

  defp scan_numbers(str) do
    head = Regex.run(~r/one|two|three|four|five|six|seven|eight|nine|[0-9]/, str) |> hd |> convert_numbers
    tail = Regex.run(~r/eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|[0-9]/, String.reverse(str)) |> hd |> String.reverse |> convert_numbers
    [head, tail]
  end

  defp convert_numbers("one") do
    1
  end
  defp convert_numbers("two") do
    2
  end
  defp convert_numbers("three") do
    3
  end
  defp convert_numbers("four") do
    4
  end
  defp convert_numbers("five") do
    5
  end
  defp convert_numbers("six") do
    6
  end
  defp convert_numbers("seven") do
    7
  end
  defp convert_numbers("eight") do
    8
  end
  defp convert_numbers("nine") do
    9
  end
  defp convert_numbers(number) do
    {n, ""} = Integer.parse(number)
    n
  end

end
