defmodule Drawtoo.UsersTest do
  use Drawtoo.DataCase

  alias Drawtoo.Users
  import Drawtoo.UsersFixtures
  import Drawtoo.GamesFixtures

  describe "users" do
    alias Drawtoo.Users.User

    @invalid_attrs %{name: nil, score: nil}

    setup [:create_game]

    test "list_users/0 returns all users", %{game: game} do
      user = user_fixture(game_id: game.id)
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id", %{game: game} do
      user = user_fixture(game_id: game.id)
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user", %{game: game} do
      valid_attrs = %{name: "some name", score: 42, game_id: game.id}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.score == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user", %{game: game} do
      user = user_fixture(game_id: game.id)
      update_attrs = %{name: "some updated name", score: 43}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.score == 43
    end

    test "update_user/2 with invalid data returns error changeset", %{game: game} do
      user = user_fixture(game_id: game.id)
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user", %{game: game} do
      user = user_fixture(game_id: game.id)
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset", %{game: game} do
      user = user_fixture(game_id: game.id)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  def create_game(params) do
    %{
      game: game_fixture(params)
    }
  end
end
