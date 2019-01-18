defmodule LoaOfLoot.WarcraftLogsTasks do
  @moduledoc """
  Scheduled tasks for pulling guild data from WCL
  """

  alias LoaOfLoot.Configs.Zone
  alias LoaOfLoot.Events
  alias LoaOfLoot.Guilds
  alias LoaOfLoot.Guilds.Log
  alias LoaOfLoot.Repo
  alias LoaOfLoot.WarcraftLogsApi

  @spell_id 128_275
  def update_guild_data(name, server, region) do
    name
    |> WarcraftLogsApi.fetch_guild_logs(server, region)
    |> parse_logs
  end

  def parse_logs({:ok, data}) do
    data
    |> Enum.filter(fn log ->
      log["zone"] >= 19
    end)
    |> Enum.each(fn log ->
      duration = log["end"] - log["start"]
      zone = Repo.get(Zone, log["zone"])
      attrs = %{
        duration: duration,
        wcl_id: log["id"]
      }
      attrs
      |> Guilds.get_or_create_log(zone)
      |> parse_log
    end)
  end
  def parse_logs({:error, _}), do: nil

  def parse_log({:error, _}), do: nil
  def parse_log({:ok, %Log{wcl_id: wcl_id, duration: duration} = log}) do
    wcl_id
    |> WarcraftLogsApi.fetch_casts(@spell_id, duration)
    |> parse_casts(log)
  end

  def parse_casts({:ok, %{"entries" => entries}}, log) do
    entries
    |> Enum.map(fn casts ->
      caster = Guilds.get_or_create_character_by_name(casts["name"])
      casts["targets"]
      |> Enum.map(fn cast ->
        target = Guilds.get_or_create_character_by_name(cast["name"])
        count = cast["total"]
        Events.update_cast(log, caster, target, count, @spell_id)
      end)
    end)
  end
  def parse_casts({:error, msg}, _), do: nil
end
