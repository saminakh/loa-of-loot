defmodule LoaOfLootWeb.ZoneController do
  use LoaOfLootWeb, :controller
  alias LoaOfLoot.{Events, Guilds}

  def index(conn, %{"id" => id}) do
    logs = Guilds.get_log_by_zone(id)
    casts =
      logs
      |> Enum.flat_map(fn log ->
        Events.get_casts_by_log(log.id)
      end)
      |> Enum.group_by(fn cast ->
        cast.caster_id
      end)
      |> Enum.map(fn {caster_id, casts} ->
        character = Guilds.get_character!(caster_id)
        %{
          caster: character.name,
          count: Enum.count(casts)
        }
      end)
      |> Enum.sort(& &1.count >= &2.count)

    conn
    |> assign(:casts, casts)
    |> render("index.html")
  end
end
