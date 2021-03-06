defmodule LoaOfLoot.Events.Cast do
  @moduledoc """
  Schema for a cast in a log
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias LoaOfLoot.Guilds.{Character, Log}

  schema "casts" do
    field(:ability_id, :integer)
    field(:count, :integer)
    belongs_to(:target, Character, [foreign_key: :target_id])
    belongs_to(:caster, Character, [foreign_key: :caster_id])
    belongs_to(:log, Log)
    timestamps()
  end

  @doc false
  def changeset(casts, attrs) do
    casts
    |> cast(attrs, [:ability_id, :target_id, :caster_id, :count])
    |> cast_assoc(:log)
    |> validate_required([:ability_id, :target_id, :caster_id, :count])
  end
end
