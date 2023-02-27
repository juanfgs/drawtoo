defmodule DrawtooWeb.Games.GameControllerTest do
  use DrawtooWeb.ConnCase

  describe "games " do
    test "entering a new game should return a new game code", %{conn: conn} do
      response = post(conn, Routes.game_path(conn, :new), %{"user_name" => "testing"})
      assert String.starts_with?(redir_path = redirected_to(response, 302), "/games/")
      response = get(recycle(conn), redir_path)
      assert html_response(response, 200) =~ "Welcome to game"
    end
  end
end
