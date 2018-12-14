defmodule LoaOfLoot.Guilds.Log do
  @moduledoc """
  Schema for a WarcraftLogs log
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field(:duration, :integer)
    field(:log_id, :string)
    field(:zone, :integer)

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:log_id, :duration, :zone])
    |> validate_required([:log_id, :duration, :zone])
    |> unique_constraint([:log_id])
  end
end
