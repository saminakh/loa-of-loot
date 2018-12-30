defmodule LoaOfLoot.Repo.Migrations.AddZoneToLog do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :zone_id, references(:zones)
    end
  create index(:logs, [:zone_id])
  end
end
