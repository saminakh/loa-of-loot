defmodule LoaOfLoot.Guilds do
  @moduledoc """
  The Guilds context.
  """

  import Ecto.Query, warn: false
  alias LoaOfLoot.Repo
  alias LoaOfLoot.Guilds.{Character, Log}

  def list_logs do
    Repo.all(Log)
  end

  def get_log!(id), do: Repo.get!(Log, id)

  def get_log_by_zone(zone_id) do
    query = from log in Log, where: log.zone_id == ^zone_id
    Repo.all(query)
  end

  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  def list_characters do
    Repo.all(Character)
  end

  def get_character!(id), do: Repo.get!(Character, id)

  def create_character(attrs \\ %{}) do
    %Character{}
    |> Character.changeset(attrs)
    |> Repo.insert()
  end
end
