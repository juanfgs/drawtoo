defmodule Drawtoo.Repo.Migrations.CreateCanvases do
  use Ecto.Migration

  def change do
    create table(:canvases, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :strokes, {:array, :map}
      add :game_id, references(:games, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:canvases, [:game_id])
  end
end
