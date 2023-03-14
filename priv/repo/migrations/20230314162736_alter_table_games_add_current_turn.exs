defmodule Drawtoo.Repo.Migrations.AlterTableGamesAddCurrentTurn do
  use Ecto.Migration

  def change do
    alter table(:games, primary_key: false) do
      add :current_turn, :integer, default: 0
      add :game_started, :boolean, default: false
      add :max_players, :integer, default: 4
    end
  end
end
