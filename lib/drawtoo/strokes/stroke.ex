defmodule Drawtoo.Strokes.Stroke do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:data]}
  schema "strokes" do
    field :data, :map
    field :canvas_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(stroke, attrs) do
    stroke
    |> cast(attrs, [:data])
    |> validate_required([:data])
  end
end
