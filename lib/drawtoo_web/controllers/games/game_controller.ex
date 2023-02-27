defmodule DrawtooWeb.Games.GameController do
  use DrawtooWeb, :controller

  alias Drawtoo.Games
  alias Drawtoo.Users

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.html", games: games)
  end

  def new(conn, %{"user_name" => username}) do
    {:ok, game} = Games.create_game(%{code: Games.generate_game_code()})
    {:ok, _user} = Users.create_user(%{name: username, game_id: game.id})

    game_path = Routes.game_path(conn, :show, String.upcase(game.code))

    conn
    |> redirect(to: game_path)
  end

  def show(conn, %{"code" => code}) do
    game = Games.get_game_by_code!(code)
    render(conn, "show.html", game: game)
  end
end
