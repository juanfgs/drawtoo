defmodule DrawtooWeb.Games.GameController do
  use DrawtooWeb, :controller

  alias Drawtoo.Games
  alias Drawtoo.Users
  alias Drawtoo.Repo

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.html", games: games)
  end

  def new(conn, %{
        "user_name" => username,
        "max_players" => max_players,
        "round_time" => round_time,
        "number_of_rounds" => number_of_rounds
      }) do
    {:ok, game} =
      Games.create_game(%{
        code: Games.generate_game_code(),
        max_players: max_players,
        round_time: round_time,
        number_of_rounds: number_of_rounds
      })

    case Users.create_user(%{name: username, game_id: game.id}) do
      {:ok, _user} ->
        game_path = Routes.game_path(conn, :show, String.upcase(game.code))

        conn
        |> redirect(to: game_path)

      {:error, %Ecto.Changeset{errors: [{field, {message, _}}]}} ->
        # We no longer need this game
        Games.delete_game(game)

        conn
        |> put_flash(:error, "#{field} : #{message}")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def show(conn, %{"code" => code}) do
    game = Games.get_game_by_code!(code)
    render(conn, "show.html", game: game)
  end

  def join(conn, %{"code" => code}) do
    game = Games.get_game_by_code!(code)
    render(conn, "join.html", game: game)
  end

  def join_post(conn, %{"code" => code, "user_name" => user_name}) do
    game = Games.get_game_by_code!(code)

    if Enum.count(game.users) < game.max_players do
      {:ok, _user} = Users.create_user(%{name: user_name, game_id: game.id})

      game_path = Routes.game_path(conn, :show, String.upcase(game.code))

      conn |> redirect(to: game_path)
    else
      conn
      |> put_flash(:error, "Game room is full")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
