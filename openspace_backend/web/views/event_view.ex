defmodule OpenspaceBackend.EventView do
  use OpenspaceBackend.Web, :view

  def render("index.json", %{events: events}) do
    %{events: render_many(events, OpenspaceBackend.EventView, "events.json")}
  end

  def render("show.json", %{event: event}) do
    %{ event: render_one(event, OpenspaceBackend.EventView, "event.json")}
    |> Map.merge(OpenspaceBackend.TrackView.render("index.json", %{tracks: event.tracks}))
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      slug: event.slug,
      track_ids: Enum.map(event.tracks, &(&1.id))
    }
  end

  def render("events.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      slug: event.slug
    }
  end
end
