defmodule Drawtoo.Canvasses.Canvas do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:strokes]}
  schema "canvases" do
    embeds_many :strokes, Drawtoo.Canvasses.Stroke, on_replace: :delete
    field :game_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(canvas, attrs) do
    canvas
    |> cast(attrs, [:game_id])
    |> cast_embed(:strokes)
  end
end
