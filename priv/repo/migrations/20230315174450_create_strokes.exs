defmodule Drawtoo.Repo.Migrations.CreateStrokes do
  use Ecto.Migration

  def change do
    create table(:strokes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :data, :map
      add :canvas_id, references(:canvases, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:strokes, [:canvas_id])
  end
end
