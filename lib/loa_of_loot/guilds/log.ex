defmodule LoaOfLoot.Guilds.Log do
  @moduledoc """
  Schema for a WarcraftLogs log
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias LoaOfLoot.Configs.Zone

  schema "logs" do
    field(:duration, :integer)
    field(:log_id, :string)
    belongs_to(:zone, Zone)

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:log_id, :duration, :zone_id])
    |> validate_required([:log_id, :duration, :zone_id])
    |> unique_constraint([:log_id])
  end
end
