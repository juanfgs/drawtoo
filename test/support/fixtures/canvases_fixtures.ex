defmodule Drawtoo.CanvassesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drawtoo.Canvasses` context.
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
      |> Drawtoo.Canvasses.create_canvas()

    canvas
  end
end
