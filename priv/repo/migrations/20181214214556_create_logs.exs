defmodule LoaOfLoot.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :log_id, :string
      add :duration, :integer

      timestamps()
    end
    create unique_index(:logs, [:log_id])
  end
end
