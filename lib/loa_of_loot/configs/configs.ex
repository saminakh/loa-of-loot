defmodule LoaOfLoot.Configs do
  @moduledoc """
  The Configs context.
  """

  import Ecto.Query, warn: false
  alias LoaOfLoot.Repo

  alias LoaOfLoot.Configs.Zone

  def list_zones do
    Repo.all(Zone)
  end

  def create_zone(attrs \\ %{}) do
    %Zone{}
    |> Zone.changeset(attrs)
    |> Repo.insert()
  end
end
