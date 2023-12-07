defmodule Day7 do
  @moduledoc """
  Module that will contain the answers
  for the day 7 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 7 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_cards(contents)
    |> hand_classifier
    |> compare_classes
    |> total_winnings
    |> Enum.sum
  end

  @spec parse_cards(String.t()) :: [{String.t(), integer()}]
  def parse_cards(input) do
    String.split(input, "\n")
    |> Enum.map(fn(card_bid) -> String.split(card_bid, " ") |> card_tuple end)
  end

  @spec card_tuple(list()) :: {String.t(), integer()}
  def card_tuple([hand, bid]) do
    {n_bid, ""} = Integer.parse(bid)
    {hand, n_bid}
  end

  @spec hand_classifier([{String.t(), integer()}]) :: map()
  def hand_classifier(hands) do
    classifier = [{:high, []}, {:one, []}, {:two, []}, {:three, []}, {:full, []}, {:four, []}, {:five, []}]
    hand_classifier(hands, Map.new(classifier))
  end
  def hand_classifier([], classifier) do
    classifier
  end
  def hand_classifier([{hand, bid} | tail], classifier) do
    case String.graphemes(hand) |> MapSet.new |> MapSet.size do
      5 -> hand_classifier(tail, add_to_classifier({hand, bid}, classifier, :high))
      4 -> hand_classifier(tail, add_to_classifier({hand, bid}, classifier, :one))
      1 -> hand_classifier(tail, add_to_classifier({hand, bid}, classifier, :five))
      2 -> hand_classifier(tail, is_fourkind({hand, bid}, classifier))
      _ -> hand_classifier(tail, is_threekind({hand, bid}, classifier))
    end
  end

  def is_threekind({hand, bid}, classifier) do
    counters = String.graphemes(hand) |> MapSet.new |> MapSet.to_list() |> Enum.zip([0,0,0]) |> Map.new
    case is_threekind2(String.graphemes(hand), counters) do
      true -> add_to_classifier({hand, bid}, classifier, :three)
      _ -> add_to_classifier({hand, bid}, classifier, :two)
    end
  end
  defp is_threekind2([], _) do
    false
  end
  defp is_threekind2([str | tail], counters) do
    new_counter = Map.fetch!(counters, str) + 1
    case new_counter do
      3 -> true
      _ -> is_threekind2(tail, Map.put(counters, str, new_counter))
    end
  end

  def is_fourkind({hand, bid}, classifier) do
    open_hand = String.graphemes(hand)
    case Enum.count(open_hand, & &1 === hd(open_hand)) do
      1 -> add_to_classifier({hand, bid}, classifier, :four)
      4 -> add_to_classifier({hand, bid}, classifier, :four)
      _ -> add_to_classifier({hand, bid}, classifier, :full)
    end
  end

  def add_to_classifier(hand, classifier, token) do
    new_class = Map.fetch!(classifier, token)
    |> Kernel.++([hand])
    Map.put(classifier, token, new_class)
  end

  def compare_classes(classifier) do
    compare_classes(classifier, :high)
    |> compare_classes(:one)
    |> compare_classes(:two)
    |> compare_classes(:three)
    |> compare_classes(:full)
    |> compare_classes(:four)
    |> compare_classes(:five)
  end
  def compare_classes(classifier, token) do
    hands = Map.fetch!(classifier, token)
    |> Enum.sort(fn({hand1, _}, {hand2, _}) -> compare_hands(String.graphemes(hand1), String.graphemes(hand2)) end)
    Map.put(classifier, token, hands)
  end

  def compare_hands([h1|t1], [h2 | t2]) do
    cond do
      card_points(h1) === card_points(h2) -> compare_hands(t1, t2)
      card_points(h1) < card_points(h2) -> true
      true -> false
    end
  end

  def card_points("A") do
    14
  end
  def card_points("K") do
    13
  end
  def card_points("Q") do
    12
  end
  def card_points("J") do
    11
  end
  def card_points("T") do
    10
  end
  def card_points(n_card) do
    {number, ""} = Integer.parse(n_card)
    number
  end

  def total_winnings(classifier) do
    [:high, :one, :two, :three, :full, :four, :five]
    |> List.foldr([], fn(token, acc) -> Map.fetch!(classifier, token) ++ acc end)
    |> Enum.with_index
    |> Enum.map(fn({{_, bid}, index}) -> bid * (index + 1) end)
  end

  @doc """
  Solution for Day 7 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_cards(contents)
    0
  end

  def card_points2("A") do
    13
  end
  def card_points2("K") do
    12
  end
  def card_points2("Q") do
    11
  end
  def card_points2("T") do
    10
  end
  def card_points2("J") do
    1
  end
  def card_points2(n_card) do
    {number, ""} = Integer.parse(n_card)
    number
  end

end
