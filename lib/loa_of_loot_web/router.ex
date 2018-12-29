defmodule LoaOfLootWeb.Router do
  use LoaOfLootWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LoaOfLootWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/zone/:id", ZoneController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", LoaOfLootWeb do
  #   pipe_through :api
  # end
end
