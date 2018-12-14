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
end
