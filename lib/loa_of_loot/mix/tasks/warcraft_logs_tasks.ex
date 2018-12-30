defmodule LoaOfLoot.WarcraftLogsTasks do
  @moduledoc """
  Scheduled tasks for pulling guild data from WCL
  """

  alias LoaOfLoot.Guilds.Log
  alias LoaOfLoot.Repo
  alias LoaOfLoot.WarcraftLogsApi

  def update_guild_data(name, server, region) do
    WarcraftLogsApi.fetch_guild_logs(name, server, region)
    |> parse_logs
  end

  def parse_logs({:ok, data}) do
    data
    |> Enum.each(fn log ->
      duration = log["end"] - log["start"]

      attrs = %{
        duration: duration,
        wcl_id: log["id"],
        zone_id: log["zone"]
      }
      %Log{}
      |> Log.changeset(attrs)
      |> Repo.insert
      |> parse_log
    end)
  end

  def parse_log({:error, _}), do: nil
  def parse_log({:ok, %Log{} = log}) do

  end
end
