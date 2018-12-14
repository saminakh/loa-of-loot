defmodule LoaOfLoot.Guilds.Character do
  @moduledoc """
  Schema for WoW characters
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint([:name])
  end
end
