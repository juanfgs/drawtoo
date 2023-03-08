defmodule Drawtoo.Canvasses.Stroke do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    @derive Jason.Encoder
    field :data, :map
  end

  def changeset(%Drawtoo.Canvasses.Stroke{} = stroke, attrs) do
    stroke
    |> cast(attrs, [
      :data
    ])
  end
end
