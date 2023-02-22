defmodule Drawtoo.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :round_time, :integer, default: 120
      add :number_of_rounds, :integer, default: 10

      timestamps()
    end

    create unique_index(:games, [:code])
  end
end
