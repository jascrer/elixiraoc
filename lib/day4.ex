defmodule Day4 do
  @moduledoc """
  Module that will contain the answers
  for the day 4 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 4 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_cards(contents)
    |> verify_cards
    |> Enum.sum()
  end

  def parse_cards(input) do
    String.split(input, "\n")
    |> Enum.map(
        fn(card) ->
          card_number = String.split(card, ":") |> hd |> String.split(" ") |> tl |> Enum.filter(fn(card) -> card !== "" end) |> hd
          cards = String.split(card, ":") |> tl |> hd |> String.split("|") |> get_cards
          [card_number, cards]
        end)
  end

  def get_cards([winning_card, numbers]) do
    w_card = String.split(winning_card, " ") |> Enum.filter(fn(card) -> card !== "" end)
    n_card = String.split(numbers, " ") |> Enum.filter(fn(card) -> card !== "" end)
    {w_card, n_card}
  end

  def verify_cards(cards) do
    Enum.map(cards, fn(card) -> check_numbers(card) end)
  end

  def check_numbers([_, {w_card, n_card}]) do
    filtered = Enum.filter(n_card, fn(number) -> number in w_card end)
    case length(filtered) do
      0 -> 0
      n -> trunc(:math.pow(2, n-1))
    end
  end

  @doc """
  Solution for Day 4 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_cards(contents)
    |> get_points
    |> get_copies
  end

  @spec get_points(list()) :: list()
  def get_points(cards) do
    Enum.map(cards,
      fn([card_number, {w_card, n_card}]) ->
        {p_number, ""} = Integer.parse(card_number)
        {p_number, Enum.filter(n_card, fn(number) -> number in w_card end) |> length}
      end)
  end

  def get_copies(cards) do
    length(cards) + length(get_copies(cards, cards, []))
  end
  def get_copies([], _original, copies) do
    copies
  end
  def get_copies([{number, points}|tail], original, copies) do
    init_copies = Enum.slice(original, number, points)
    derived_copies = get_copies(init_copies, original, [])
    get_copies(tail, original, copies ++ List.flatten([init_copies ++ derived_copies]))
  end

end
