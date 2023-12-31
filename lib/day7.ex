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

  defp parse_cards(input) do
    String.split(input, "\n")
    |> Enum.map(& String.split(&1, " ") |> card_tuple)
  end

  @spec card_tuple(list()) :: {String.t(), integer()}
  def card_tuple([hand, bid]), do: ({n_bid, ""} = Integer.parse(bid); {hand, n_bid})

  @spec hand_classifier([{String.t(), integer()}]) :: map()
  def hand_classifier(hands) do
    classifier = [{:high, []}, {:one, []}, {:two, []}, {:three, []}, {:full, []}, {:four, []}, {:five, []}]
    hand_classifier(hands, Map.new(classifier))
  end
  defp hand_classifier([], classifier), do: classifier
  defp hand_classifier([{hand, bid} | tail], classifier) do
    case String.graphemes(hand) |> MapSet.new |> MapSet.size do
      5 -> hand_classifier(tail, add_to_classifier({hand, bid}, classifier, :high))
      4 -> hand_classifier(tail, add_to_classifier({hand, bid}, classifier, :one))
      1 -> hand_classifier(tail, add_to_classifier({hand, bid}, classifier, :five))
      2 -> hand_classifier(tail, is_fourkind({hand, bid}, classifier))
      _ -> hand_classifier(tail, is_threekind({hand, bid}, classifier))
    end
  end

  defp is_threekind({hand, bid}, classifier) do
    counters = String.graphemes(hand) |> MapSet.new |> MapSet.to_list() |> Enum.zip([0,0,0]) |> Map.new
    case is_threekind2(String.graphemes(hand), counters) do
      true -> add_to_classifier({hand, bid}, classifier, :three)
      _ -> add_to_classifier({hand, bid}, classifier, :two)
    end
  end
  defp is_threekind2([], _), do: false
  defp is_threekind2([str | tail], counters) do
    new_counter = Map.fetch!(counters, str) + 1
    case new_counter do
      3 -> true
      _ -> is_threekind2(tail, Map.put(counters, str, new_counter))
    end
  end

  defp is_fourkind({hand, bid}, classifier) do
    open_hand = String.graphemes(hand)
    case Enum.count(open_hand, & &1 === hd(open_hand)) do
      1 -> add_to_classifier({hand, bid}, classifier, :four)
      4 -> add_to_classifier({hand, bid}, classifier, :four)
      _ -> add_to_classifier({hand, bid}, classifier, :full)
    end
  end

  defp add_to_classifier(hand, classifier, token) do
    new_class = Map.fetch!(classifier, token)
    |> Kernel.++([hand])
    Map.put(classifier, token, new_class)
  end

  defp compare_classes(classifier) do
    compare_classes(classifier, :high)
    |> compare_classes(:one)
    |> compare_classes(:two)
    |> compare_classes(:three)
    |> compare_classes(:full)
    |> compare_classes(:four)
    |> compare_classes(:five)
  end
  defp compare_classes(classifier, token) do
    hands = Map.fetch!(classifier, token)
    |> Enum.sort(fn({hand1, _}, {hand2, _}) -> compare_hands(String.graphemes(hand1), String.graphemes(hand2)) end)
    Map.put(classifier, token, hands)
  end

  defp compare_hands([h1|t1], [h2 | t2]) do
    cond do
      card_points(h1) === card_points(h2) -> compare_hands(t1, t2)
      card_points(h1) < card_points(h2) -> true
      true -> false
    end
  end

  defp card_points("A"), do: 14
  defp card_points("K"), do: 13
  defp card_points("Q"), do: 12
  defp card_points("J"), do: 11
  defp card_points("T"), do: 10
  defp card_points(n_card), do: ({number, ""} = Integer.parse(n_card); number)

  defp total_winnings(classifier) do
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
    |> hand_classifier2
    |> compare_classes2
    |> total_winnings
    |> Enum.sum
  end

  @spec hand_classifier2([{String.t(), integer()}]) :: map()
  def hand_classifier2(hands) do
    classifier = [{:high, []}, {:one, []}, {:two, []}, {:three, []}, {:full, []}, {:four, []}, {:five, []}]
    hand_classifier2(hands, Map.new(classifier))
  end
  defp hand_classifier2([], classifier), do: classifier
  defp hand_classifier2([{hand, bid} | tail], classifier) do
    cond do
      String.graphemes(hand) |> Enum.count(& &1 == "J") > 0 -> hand_classifier2(tail, joker_hands({hand,bid}, classifier))
      true -> hand_classifier2(tail, classic_hands({hand,bid}, classifier))
    end
  end

  defp joker_hands({hand, bid}, classifier) do
    case String.graphemes(hand) |> MapSet.new |> MapSet.size do
      1 -> add_to_classifier({hand, bid}, classifier, :five)
      2 -> add_to_classifier({hand, bid}, classifier, :five)
      3 -> alone_joker({hand, bid}, classifier)
      4 -> add_to_classifier({hand, bid}, classifier, :three)
      _ -> add_to_classifier({hand, bid}, classifier, :one)
    end
  end

  defp alone_joker({hand, bid}, classifier) do
    mapset_list = String.graphemes(hand) |> MapSet.new |> MapSet.to_list()
    zero_list = List.duplicate(0, length(mapset_list))
    counters = mapset_list |> Enum.zip(zero_list) |> Map.new
    case count_symbols(String.graphemes(hand), counters) do
      [{_,2},{_,2},{"J", 1}] -> add_to_classifier({hand, bid}, classifier, :full)
      _ -> add_to_classifier({hand, bid}, classifier, :four)
    end
  end

  defp count_symbols([], counters) do
    Map.to_list(counters)
    |> Enum.sort(fn({_, p1},{_, p2}) -> p1 > p2 end)
  end
  defp count_symbols([str | tail], counters) do
    new_counter = Map.fetch!(counters, str) + 1
    count_symbols(tail, Map.put(counters, str, new_counter))
  end


  defp compare_classes2(classifier) do
    compare_classes2(classifier, :high)
    |> compare_classes2(:one)
    |> compare_classes2(:two)
    |> compare_classes2(:three)
    |> compare_classes2(:full)
    |> compare_classes2(:four)
    |> compare_classes2(:five)
  end
  defp compare_classes2(classifier, token) do
    hands = Map.fetch!(classifier, token)
    |> Enum.sort(fn({hand1, _}, {hand2, _}) -> compare_hands2(String.graphemes(hand1), String.graphemes(hand2)) end)
    Map.put(classifier, token, hands)
  end

  defp compare_hands2([h1|t1], [h2 | t2]) do
    cond do
      card_points2(h1) === card_points2(h2) -> compare_hands2(t1, t2)
      card_points2(h1) < card_points2(h2) -> true
      true -> false
    end
  end

  defp classic_hands({hand, bid}, classifier) do
    case String.graphemes(hand) |> MapSet.new |> MapSet.size do
      5 -> add_to_classifier({hand, bid}, classifier, :high)
      4 -> add_to_classifier({hand, bid}, classifier, :one)
      1 -> add_to_classifier({hand, bid}, classifier, :five)
      2 -> is_fourkind({hand, bid}, classifier)
      _ -> is_threekind({hand, bid}, classifier)
    end
  end

  defp card_points2("A"), do: 13
  defp card_points2("K"), do: 12
  defp card_points2("Q"), do: 11
  defp card_points2("T"), do: 10
  defp card_points2("J"), do: 1
  defp card_points2(n_card), do: ({number, ""} = Integer.parse(n_card); number)

end
