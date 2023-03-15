defmodule Drawtoo.Canvasses.Canvas do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "canvases" do
    @derive Jason.Encoder
    has_many :strokes, Drawtoo.Strokes.Stroke
    field :game_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(canvas, attrs) do
    canvas
    |> cast(attrs, [:game_id])
    |> cast_assoc(:strokes)
  end
end
