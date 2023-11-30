defmodule Day0 do
  @moduledoc """
  Template file for the Puzzles of Advent of Code 2023
  Module that will contain the answers
  for the day 0 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 0 Puzzle 1
  """
  @spec puzzle1(String.t()) :: String.t()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    contents
  end

  @doc """
  Solution for Day 0 Puzzle 2
  """
  @spec puzzle2(String.t()) :: nil
  def puzzle2(_fileName) do

  end
end
