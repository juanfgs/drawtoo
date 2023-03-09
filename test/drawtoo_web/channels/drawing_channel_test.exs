defmodule DrawtooWeb.DrawingChannelTest do
  use DrawtooWeb.ChannelCase

  import Drawtoo.GamesFixtures

  setup do
    game = game_fixture(%{})

    {:ok, _, socket} =
      DrawtooWeb.DrawingSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(DrawtooWeb.DrawingChannel, "room:#{game.code}")

    %{socket: socket}
  end

  test "initializes the sketchpad, returns an empty canvas if first call", %{socket: socket} do
    ref = push(socket, "sketchpad_initialize", %{"data" => "sample data"})

    assert_reply ref, :ok, %{"data" => "sample data"}
  end

  # test "shout broadcasts to drawing:lobby", %{socket: socket} do
  #   push(socket, "shout", %{"hello" => "all"})
  #   assert_broadcast "shout", %{"hello" => "all"}
  # end

  # test "broadcasts are pushed to the client", %{socket: socket} do
  #   broadcast_from!(socket, "broadcast", %{"some" => "data"})
  #   assert_push "broadcast", %{"some" => "data"}
  # end
end
