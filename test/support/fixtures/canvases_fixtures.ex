defmodule Drawtoo.CanvasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drawtoo.Canvases` context.
  """

  @doc """
  Generate a canvas.
  """
  def canvas_fixture(attrs \\ %{}) do
    {:ok, canvas} =
      attrs
      |> Enum.into(%{
        strokes: []
      })
      |> Drawtoo.Canvases.create_canvas()

    canvas
  end
end
