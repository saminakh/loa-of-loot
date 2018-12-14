defmodule LoaOfLoot.WarcraftLogsApi do
  @moduledoc """
  Api for warcraft logs
  """
  alias HTTPoison.Response
  alias LoaOfLoot.WarcraftLogs

  def fetch_guild_logs(name, server, region) do
    "/v1/reports/guild/#{name}/#{server}/#{region}"
    |> WarcraftLogs.get()
    |> handle_response
  end

  def fetch_casts(log_id, ability_id, duration) do
    options = [params: %{end: duration, abilityid: ability_id}]

    "/v1/report/tables/casts/#{log_id}"
    |> WarcraftLogs.get([], options)
    |> handle_response
  end

  defp handle_response({:ok, %Response{body: body, status_code: 200}}),
    do: {:ok, body}

  defp handle_response({:ok, %Response{body: body, status_code: 404}}),
    do: {:error, body}

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}),
    do: {:error, reason}
end
