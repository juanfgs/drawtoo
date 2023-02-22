defmodule Drawtoo.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drawtoo.Games` context.
  """

  @doc """
  Generate a unique game code.
  """
  def unique_game_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        code: unique_game_code(),
        number_of_rounds: 42,
        round_time: 42
      })
      |> Drawtoo.Games.create_game()

    game
  end
end
