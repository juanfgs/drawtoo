defmodule Drawtoo.Canvases.Canvas do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "canvases" do
    embeds_many :strokes, Stroke, on_replace: :update
    field :game_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(canvas, attrs) do
    canvas
    |> cast(attrs, [:strokes])
    |> validate_required([:strokes])
  end
end
