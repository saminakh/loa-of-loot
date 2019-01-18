defmodule LoaOfLoot.Guilds do
  @moduledoc """
  The Guilds context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
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

  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  def create_log(attrs, zone) do
    %Log{}
    |> Log.changeset(attrs)
    |> Changeset.put_assoc(:zone, zone)
    |> Repo.insert()
  end

  def get_or_create_log(%{wcl_id: id, duration: duration} = attrs, zone) do
    case Repo.get_by(Log, wcl_id: id) do
      nil -> create_log(attrs, zone)
      log ->
        if duration > log.duration do
          update_log(log, attrs)
        else
          {:error, "No updates to log"}
        end
    end
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

  def create_character!(attrs \\ %{}) do
    %Character{}
    |> Character.changeset(attrs)
    |> Repo.insert!()
  end

  def get_or_create_character_by_name(name) do
    case Repo.get_by(Character, name: name) do
      nil -> create_character!(%{name: name})
      character -> character
    end
  end
end
