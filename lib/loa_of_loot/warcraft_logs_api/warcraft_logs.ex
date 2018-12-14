defmodule LoaOfLoot.WarcraftLogs do
  @moduledoc """
  Api wrapper for warcraft logs
  """
  use HTTPoison.Base

  def process_request_url(url), do: "https://www.warcraftlogs.com/" <> url

  def process_response_body(body), do: Poison.decode!(body)

  def process_request_headers(headers) do
    Keyword.merge(headers, "Content-Type": "application/json")
  end

  def process_request_options(options) do
    key = Application.get_env(:loa_of_loot, :wcl_api_key)
    params = options[:params] || %{}
    Keyword.merge(options, params: Map.merge(params, %{api_key: key}))
  end
end
