defmodule Drawtoo.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drawtoo.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        score: 42
      })
      |> Drawtoo.Users.create_user()

    user
  end
end
