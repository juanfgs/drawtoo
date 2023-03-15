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

    test "if the user doesn't introduce their name it should raise an error", %{conn: conn} do
      navigate_to("http://localhost:4002")

      element = find_element(:id, "user_name")

      submit_element(element)

      share_game = find_element(:css, ".alert-danger")

      assert inner_text(share_game) =~
               "name : can't be blank"
    end

    test "joining a game through a game link should display " do
      navigate_to("http://localhost:4002/")

      element = find_element(:id, "user_name")

      fill_field(element, "Test user1234")
      submit_element(element)

      share_game = find_element(:css, "#share-game")

      "Share this code with your friends to let them join this game: " <> code =
        inner_text(share_game)

      navigate_to("http://localhost:4002/games/join/#{code}")

      element = find_element(:id, "user_name")

      fill_field(element, "Test user12345")
      submit_element(element)

      share_game = find_element(:css, "#share-game")

      assert inner_text(share_game) =~
               "Share this code with your friends to let them join this game"
    end

    test "should not let join more users than max_players " do
      navigate_to("http://localhost:4002/")

      element = find_element(:id, "user_name")
      max_players_el = find_element(:id, "max_players")

      fill_field(element, "Test user1234")
      fill_field(max_players_el, 3)
      submit_element(element)

      share_game = find_element(:css, "#share-game")

      "Share this code with your friends to let them join this game: " <> code =
        inner_text(share_game)

      for i <- 0..2 do
        navigate_to("http://localhost:4002/games/join/#{code}")

        element = find_element(:id, "user_name")

        fill_field(element, "Test user#{i}")
        submit_element(element)
      end

      navigate_to("http://localhost:4002/games/join/#{code}")

      element = find_element(:id, "user_name")

      fill_field(element, "Test user4")
      submit_element(element)

      error = find_element(:css, ".alert-danger")

      assert inner_text(error) =~
               "Game room is full"
    end
  end
end
