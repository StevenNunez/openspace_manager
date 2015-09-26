defmodule OpenspaceBackend.Router do
  use OpenspaceBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:4200"]
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", OpenspaceBackend do
    pipe_through :api
    resources "/events", EventController, param: "slug"
    resources "/tracks", TrackController, param: "slug"
    options "/events", EventController, :options
    options "/tracks", EventController, :options
  end
end
