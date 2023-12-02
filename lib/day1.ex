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
    |> sum_numbers
  end

  defp parse_lines(lines) do
    String.split(lines, "\n")
    |> Enum.map(fn(str) -> String.graphemes(str) |> delete_characters end)
  end

  defp delete_characters(charList) do
    Enum.filter(charList, fn(charac) -> Integer.parse(charac) !== :error end)
  end
  defp sum_numbers(listNumbers) do
      List.foldr(listNumbers, 0, fn(singleNumber, acc) -> total = number_converter(singleNumber); total + acc end)
  end

  defp number_converter(singleNumber) do
    {head, ""} = Integer.parse(hd(singleNumber))
    (head * 10) + number_converter((hd(singleNumber)), tl(singleNumber))
  end
  defp number_converter(head, []) do
    {tail, ""} = Integer.parse(head)
    tail
  end
  defp number_converter(_, list) do
    number_converter(hd(list), tl(list))
  end

  @doc """
  Solution for Day 1 Puzzle 2
  """
  @spec puzzle2(String.t()) :: list()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_numbers(contents)
  end

  defp parse_numbers(lines) do
    String.split(lines, "\n")
    |> Enum.map(fn(str) -> scan_numbers(str) |> extract_numbers end)
    |> List.foldr(0, fn(total, acc) -> total+acc end)
  end

  defp extract_numbers(list) do
    head = hd(list) |> convert_numbers(:head)
    tail = extract_numbers(hd(list),tl(list)) |> convert_numbers(:tail)
    (head * 10) + tail
  end
  defp extract_numbers(head, []) do
    head
  end
  defp extract_numbers(_, list) do
    extract_numbers(hd(list), tl(list))
  end

  defp scan_numbers(str) do
    Regex.scan(~r/twone|oneight|eightwo|one|two|three|four|five|six|seven|eight|nine|[0-9]/, str)
  end

  defp convert_numbers(["twone"],:head) do
    2
  end
  defp convert_numbers(["twone"],:tail) do
    1
  end
  defp convert_numbers(["eightwo"],:head) do
    8
  end
  defp convert_numbers(["oneight"],:head) do
    1
  end
  defp convert_numbers(["eightwo"], :tail) do
    2
  end
  defp convert_numbers(["oneight"], :tail) do
    8
  end
  defp convert_numbers(["one"], _) do
    1
  end
  defp convert_numbers(["two"], _) do
    2
  end
  defp convert_numbers(["three"], _) do
    3
  end
  defp convert_numbers(["four"], _) do
    4
  end
  defp convert_numbers(["five"], _) do
    5
  end
  defp convert_numbers(["six"], _) do
    6
  end
  defp convert_numbers(["seven"], _) do
    7
  end
  defp convert_numbers(["eight"], _) do
    8
  end
  defp convert_numbers(["nine"], _) do
    9
  end
  defp convert_numbers([number], _) do
    {n, ""} = Integer.parse(number)
    n
  end

end
