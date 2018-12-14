defmodule LoaOfLoot.WarcraftLogsTest do
  use LoaOfLoot.DataCase
  alias LoaOfLoot.WarcraftLogs

  test "process_request_url/1" do
    assert WarcraftLogs.process_request_url("endpoint") =~ "https://www.warcraftlogs.com/endpoint"
  end

  test "process_request_options/1" do
    options = WarcraftLogs.process_request_options([params: %{hello: "world"}])
    assert Keyword.get(options, :params) == %{hello: "world", api_key: "test-key"}
  end

  test "process_request_options/1 with nil params" do
    options = WarcraftLogs.process_request_options([])
    assert Keyword.get(options, :params) == %{api_key: "test-key"}
  end
end
