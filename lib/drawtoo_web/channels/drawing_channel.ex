defmodule DrawtooWeb.DrawingChannel do
  use DrawtooWeb, :channel
  require Logger
  alias Drawtoo.Games
  alias Phoenix.Socket
  alias Drawtoo.Canvasses
  @impl true
  def join("room:" <> room_code, payload, socket) do
    # TODO implement authorization
    case Games.get_game_by_code(room_code) do
      %Drawtoo.Games.Game{} = game ->
        {:ok, socket |> Socket.assign(:game, game)}

      nil ->
        {:error, %{reason: "no game found"}}
    end
  end

  @impl true
  def handle_in(
        "sketchpad_initialize",
        payload,
        %{assigns: %{game: %{canvas: nil} = game}} = socket
      ) do
    Logger.info("Initializing empty canvas")

    {:ok, canvas} = Canvasses.create_canvas(%{game_id: game.id, strokes: []})

    {:reply, {:ok, payload},
     socket
     |> Socket.assign(:game, %{game | canvas: canvas})}
  end

  @impl true
  def handle_in("sketchpad_initialize", payload, socket) do
    Logger.info("Initializing sketchpad")
    Logger.info(inspect(payload))
    Logger.info(inspect(socket.assigns.game.canvas.strokes))

    socket
    |> broadcast("sketchpad_content_update", %{data: socket.assigns.game.canvas.strokes})

    {:reply, {:ok, payload}, socket}
  end

  @impl true
  def handle_in("sketchpad_status", %{"data" => data} = payload, socket) do
    Logger.info("Sketchpad status update")
    Logger.info(inspect(socket))

    socket.assigns.game.canvas
    |> Canvasses.append_stroke(%{data: data})

    socket.assigns.game.canvas.strokes
    |> Enum.each(fn stroke ->
      socket
      |> broadcast("sketchpad_content_update", %{
        data: socket.assigns.game.canvas.strokes
      })
    end)

    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp validate_game_by_code(_payload) do
    true
  end
end
