defmodule Drawtoo.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "games" do
    field :code, :string
    field :round_time, :integer
    field :number_of_rounds, :integer

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:code, :round_time, :number_of_rounds])
    |> validate_required([:code])
  end
end
