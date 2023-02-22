defmodule Drawtoo.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :score, :integer
    belongs_to :game, Drawtoo.Games.Game, foreign_key: :game_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :score, :game_id])
    |> cast_assoc(:game)
    |> validate_required([:name, :game_id])
  end
end
