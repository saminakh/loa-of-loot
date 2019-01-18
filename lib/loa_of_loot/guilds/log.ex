defmodule LoaOfLoot.Guilds.Log do
  @moduledoc """
  Schema for a WarcraftLogs log
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias LoaOfLoot.Configs.Zone

  schema "logs" do
    field(:duration, :integer)
    field(:wcl_id, :string)
    belongs_to(:zone, Zone)

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:wcl_id, :duration])
    |> cast_assoc(:zone)
    |> validate_required([:wcl_id, :duration])
    |> unique_constraint(:wcl_id)
  end
end
