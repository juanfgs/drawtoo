defmodule Drawtoo.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Drawtoo.Repo

  alias Drawtoo.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_by_code!(code), do: Repo.get_by!(Game, code: String.downcase(code))

  @doc """
  Returns a boolean indicating if the game with the given game code already exists.


  ## Examples

      iex> game_with_code_exists?("ht432s")
      true

      iex> game_with_code_exists?("fC394d")
      false

  """
  defp game_with_code_exists?(code),
    do: Game |> where(code: ^String.downcase(code)) |> Repo.exists?()

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  @doc """
  Returns an unique game code 

  ## Examples

      iex> generate_game_code()
      "tr789s"

  """
  def generate_game_code do
    code =
      (Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9))
      |> Enum.take_random(Game.game_code_length())
      |> List.to_string()

    if game_with_code_exists?(code) do
      generate_game_code()
    else
      code
    end
  end
end
