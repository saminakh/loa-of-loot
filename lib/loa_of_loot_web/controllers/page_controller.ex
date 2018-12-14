defmodule LoaOfLootWeb.PageController do
  use LoaOfLootWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
