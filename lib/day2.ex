defmodule Day2 do
  @moduledoc """
  Module that will contain the answers
  for the day 2 of Advent of Code 2023.
  """

  @doc """
  Solution for Day 2 Puzzle 1
  """
  @spec puzzle1(String.t()) :: integer()
  def puzzle1(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_games1(contents)
    |> verify_game1()
    |> List.foldr(0, fn({gameId, _subsets}, acc) -> gameId + acc end)
  end

  defp parse_games1(games) do
    String.split(games, "\n")
    |> Enum.map(fn(game) -> format_game1(game) end )
  end

  defp format_game1(game) do
    splitGame = String.split(game, ":")
    {idGame, ""} = String.split(hd(splitGame), " ") |> tl |> hd |> Integer.parse
    gamesInfo = tl(splitGame) |> hd
      |> String.split(";")
      |> Enum.map(fn(subsets) -> String.split(subsets, ",") |> convert_cubes1 end)
    {idGame, gamesInfo}
  end

  defp convert_cubes1(cubes) do
    Enum.map(cubes,
      fn(cube) ->
        spCube = String.trim(cube, " ")
        |> String.split(" ");
        {number, ""} = hd(spCube) |> Integer.parse;
        case spCube do
          [_, "green"] -> {:green, number}
          [_, "blue"] -> {:blue, number}
          [_, "red"] -> {:red, number}
        end
      end)
    |> Map.new
  end

  defp verify_game1(games) do
    Enum.filter(games,
      fn({_gamesId, subsets}) ->
        subset_satisfies(subsets)
      end)
  end

  def subset_satisfies(subset) do
    List.foldr(subset, true,
      fn(cube, acc) ->
        cube_satisfies(cube) and acc
      end);
  end

  def cube_satisfies(cube) do
    bag = Map.new([{:red, 12}, {:green, 13}, {:blue, 14}])
    List.foldr([:green, :blue, :red], true,
      fn(color, acc) ->
        ver = Map.fetch(cube, color) <= Map.fetch(bag, color);
        ver and acc
      end)
  end

  @doc """
  Solution for Day 2 Puzzle 2
  """
  @spec puzzle2(String.t()) :: integer()
  def puzzle2(fileName) do
    {:ok, contents} = File.read(fileName)
    parse_games1(contents)
    |> games_power
    |> Enum.sum
  end

  defp games_power(games) do
    Enum.map(games,
      fn({_gamesId, subsets}) ->
        max_cube = subset_power(subsets)
        {:ok, red_value} = Map.fetch(max_cube, :red)
        {:ok, green_value} = Map.fetch(max_cube, :green)
        {:ok, blue_value} = Map.fetch(max_cube, :blue)
        red_value*green_value*blue_value
      end)
  end

  def subset_power(subset) do
    cube = Map.new([{:red, 0}, {:green, 0}, {:blue, 0}])
    List.foldr(subset, cube,
      fn(cube, acc) ->
        cube_comparison(acc, cube)
      end)
  end

  def cube_comparison(max_cube, cube) do
    List.foldr([:green, :blue, :red], max_cube,
      fn(color, acc) ->
        {:ok, max_number} = Map.fetch(acc, color)
        case Map.fetch(cube, color) do
          {:ok, number} -> Map.put(acc, color, max(number, max_number))
          _ -> acc
        end
      end)
  end

end
