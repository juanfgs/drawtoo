defmodule Drawtoo.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @game_code_length 6
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "games" do
    field :code, :string
    field :round_time, :integer
    field :number_of_rounds, :integer
    field :max_players, :integer
    field :current_turn, :integer, default: 0
    has_one :canvas, Drawtoo.Canvasses.Canvas, foreign_key: :game_id
    has_many :users, Drawtoo.Users.User
    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:code, :max_players, :current_turn, :round_time, :number_of_rounds])
    |> validate_required([:code])
  end

  def game_code_length do
    @game_code_length
  end
end
