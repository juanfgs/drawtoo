defmodule DrawtooWeb.Games.GameControllerTest do
  use DrawtooWeb.ConnCase
  use Hound.Helpers

  setup do
    Hound.start_session()
    :ok
  end

  describe "games " do
    test "entering a new game should return a new game code", %{conn: conn} do
      navigate_to("http://localhost:4002")

      element = find_element(:id, "user_name")

      fill_field(element, "Test user1234")
      submit_element(element)

      share_game = find_element(:css, "#share-game")

      assert inner_text(share_game) =~
               "Share this code with your friends to let them join this game"
    end
  end
end
