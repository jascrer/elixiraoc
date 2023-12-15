defmodule Day13 do
  @moduledoc """
  Module that will contain the answers
  for the day 13 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 13 Puzzle 1
  """
  @spec puzzle1(String.t()) :: any()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_mirrors(contents)
    |> Enum.map(& &1 |> find_greatest_line)
    |> List.foldr(0,
        fn({ori, value}, acc) ->
          case ori do
            :h -> (value * 100) + acc
            _ -> value + acc
          end
        end)
  end

  defp parse_mirrors(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(
      fn(mirror) ->
        mirror
        |> String.split("\n")
        |> Enum.map(&(String.graphemes(&1)))
      end)
  end

  @spec find_greatest_line(list()) :: {:h, integer()} | {:v, integer()}
  def find_greatest_line(lines) do
    t_lines = lines |> transpose
    h = lines |> find_line()
    v = t_lines |> find_line()
    case {h, v} do
      {:not_found, {v_idx1, _v_idx2}} -> {:v, v_idx1}
      {{h_idx1, _h_idx2}, :not_found} -> {:h, h_idx1}
      _ -> {:v, 0}
    end
  end

  @spec transpose(list()) :: [[...]]
  def transpose([]), do: []
  def transpose([[] | xss]), do: transpose(xss)
  def transpose([[x | xs] | xss]) do
    [[x | (for [h | _t] <- xss, do: h)] | transpose([xs | (for [_h | t] <- xss, do: t)])]
  end

  @spec index_can_propagate(list(), {number(),number()}) :: boolean()
  def index_can_propagate(lines, {idx1, idx2}) do
    index_can_propagate(lines, {idx1-1, idx2-1}, 1)
  end
  @spec index_can_propagate(list(), {number(),number()}, number()) :: boolean()
  def index_can_propagate(lines, {idx1, idx2}, idx) do
    cond do
      idx1 - idx < 0 or idx2 + idx === length(lines) -> true
      Enum.at(lines, idx1 - idx) === Enum.at(lines, idx2 + idx) -> index_can_propagate(lines, {idx1, idx2}, idx + 1)
      true -> false
    end
  end

  @spec find_line(any()) :: {integer(),integer()} | :not_found
  def find_line(lines) do
    lines
    |> Enum.with_index(1)
    |> find_line2(lines)
  end

  defp find_line2([_ | []], _) do
    :not_found
  end
  defp find_line2([{elems1, idx1}, {elems2, idx2} | tail], lines) do
    cond do
      elems1 === elems2 and index_can_propagate(lines, {idx1, idx2}) -> {idx1, idx2}
      true -> find_line2([{elems2, idx2} | tail], lines)
    end
  end

  @doc """
  Solution for Day 13 Puzzle 2
  """
  @spec puzzle2(String.t()) :: any()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_mirrors(contents)
    |> Enum.map(& &1 |> find_greatest_line2)
    |> List.foldr(0,
        fn({ori, value}, acc) ->
          case ori do
            :h -> (value * 100) + acc
            _ -> value + acc
          end
        end)
  end

  @spec find_greatest_line2(list()) :: {:h, integer()} | {:v, integer()}
  def find_greatest_line2(lines) do
    t_lines = lines |> transpose
    h = lines |> find_line_2()
    v = t_lines |> find_line_2()
    case {h, v} do
      {{h_idx1, _h_idx2}, {v_idx1, _v_idx2}} -> {:v, h_idx1*100 + v_idx1}
      {:not_found, {v_idx1, _v_idx2}} -> {:v, v_idx1}
      {{h_idx1, _h_idx2}, :not_found} -> {:h, h_idx1}
    end
  end

  @spec find_line_2(any()) :: {integer(),integer()} | :not_found
  def find_line_2(lines) do
    lines
    |> Enum.with_index(1)
    |> find_line_22(lines)
  end

  defp find_line_22([_ | []], _), do: :not_found
  defp find_line_22([{elems1, idx1}, {elems2, idx2} | tail], lines) do
    cond do
      compare_lines(elems1, elems2, 0) and index_can_propagate2(lines, {idx1, idx2}) -> {idx1, idx2}
      true -> find_line_22([{elems2, idx2} | tail], lines)
    end
  end

  def compare_lines([], _, _acc), do: true
  def compare_lines([head1 | tail1], [head2 | tail2], acc) do
    cond do
      head1 == head2 -> compare_lines(tail1, tail2, acc)
      acc == 1 -> false
      true -> compare_lines(tail1, tail2, acc + 1)
    end
  end

  @spec index_can_propagate2(list(), {number(),number()}) :: boolean()
  def index_can_propagate2(lines, {idx1, idx2}), do: index_can_propagate2(lines, {idx1-1, idx2-1}, 1)
  @spec index_can_propagate2(list(), {number(),number()}, number()) :: boolean()
  def index_can_propagate2(lines, {idx1, idx2}, idx) do
    cond do
      idx1 - idx < 0 or idx2 + idx == length(lines) -> true
      compare_lines(Enum.at(lines, idx1 - idx), Enum.at(lines, idx2 + idx), 0) -> index_can_propagate2(lines, {idx1, idx2}, idx + 1)
      true -> false
    end
  end
end
