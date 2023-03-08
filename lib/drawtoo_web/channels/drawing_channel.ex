defmodule DrawtooWeb.DrawingChannel do
  use DrawtooWeb, :channel
  require Logger
  alias Drawtoo.Games
  alias Phoenix.Socket

  @impl true
  def join("room:" <> room_code, payload, socket) do
    # TODO implement authorization
    IO.inspect(room_code)

    case Games.get_game_by_code(room_code) do
      %Drawtoo.Games.Game{} = game ->
        {:ok, socket |> Socket.assign(:game, game)}

      nil ->
        {:error, %{reason: "no game found"}}
    end
  end

  @impl true
  def handle_in("sketchpad_initialize", payload, socket) do
    IO.inspect(socket)
    Logger.info("Initializing sketchpad")
    Logger.info(inspect(payload))

    {:reply, {:ok, payload}, socket}
  end

  @impl true
  def handle_in("sketchpad_status", payload, socket) do
    Logger.info("Sketchpad status update")
    Logger.info(inspect(payload))

    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp validate_game_by_code(_payload) do
    true
  end
end
