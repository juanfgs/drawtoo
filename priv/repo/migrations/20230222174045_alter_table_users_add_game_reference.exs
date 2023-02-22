defmodule Drawtoo.Repo.Migrations.AlterTableUsersAddGameReference do
  use Ecto.Migration

  def change do
    alter table(:users, primary_key: false) do
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id), null: false
    end
  end
end
