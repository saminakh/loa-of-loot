defmodule LoaOfLoot.Configs.Zone do
  @moduledoc """
  The Configs context.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "zones" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(zone, attrs) do
    zone
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
