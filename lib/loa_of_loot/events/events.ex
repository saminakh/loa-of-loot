defmodule LoaOfLoot.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias LoaOfLoot.Repo

  alias LoaOfLoot.Events.Cast

  def create_cast(attrs, log) do
    %Cast{}
    |> Cast.changeset(attrs)
    |> Changeset.put_assoc(:log, log)
    |> Repo.insert()
  end

  def get_casts_by_log(log_id) do
    query = from cast in Cast, where: cast.log_id == ^log_id
    Repo.all(query)
  end

  def update_cast(log, caster, target, count, ability_id) do
    query = from cast in Cast,
      join: c in assoc(cast, :caster),
      join: t in assoc(cast, :target),
      where: cast.log_id == ^log.id and
        c.id == ^caster.id and
        t.id == ^target.id

    case Repo.one(query) do
      nil ->
        create_cast(%{
          ability_id: ability_id,
          count: count,
          target_id: target.id,
          caster_id: caster.id
        }, log)
      cast -> update_cast(cast, %{count: count})
    end
  end

  def update_cast(%Cast{} = cast, attrs) do
    cast
    |> Cast.changeset(attrs)
    |> Repo.update()
  end
  def update_cast(_, _), do: nil
end
