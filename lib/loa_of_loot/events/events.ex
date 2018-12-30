defmodule LoaOfLoot.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias LoaOfLoot.Repo

  alias LoaOfLoot.Events.Cast

  def create_casts(attrs \\ %{}) do
    %Cast{}
    |> Cast.changeset(attrs)
    |> Repo.insert()
  end

  def get_casts_by_log(log_id) do
    query = from cast in Cast, where: cast.log_id == ^log_id
    Repo.all(query)
  end
end
