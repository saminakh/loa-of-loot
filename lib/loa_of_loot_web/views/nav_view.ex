defmodule LoaOfLootWeb.NavView do
  use LoaOfLootWeb, :view
  alias LoaOfLoot.Configs
  alias LoaOfLoot.Configs.Zone

  def list_zones do
    Configs.list_zones()
  end

  def zone_name(%Zone{name: name}), do: name
  def zone_id(%Zone{id: id}), do: id
end
