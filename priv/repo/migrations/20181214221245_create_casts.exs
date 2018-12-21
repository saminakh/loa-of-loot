defmodule LoaOfLoot.Repo.Migrations.CreateCasts do
  use Ecto.Migration

  def change do
    create table(:casts) do
      add :ability_id, :integer
      add :target_id, references(:characters)
      add :caster_id, references(:characters)
      add :log_id, references(:logs)

      timestamps()
    end
    create index(:casts, [:caster_id])
  end
end
