defmodule OpenspaceBackend.TrackView do
  use OpenspaceBackend.Web, :view

  def render("index.json", %{tracks: tracks}) do
    %{tracks: render_many(tracks, OpenspaceBackend.TrackView, "track.json")}
  end

  def render("show.json", %{track: track}) do
    %{track: render_one(track, OpenspaceBackend.TrackView, "track.json")}
  end

  def render("track.json", %{track: track}) do
    %{id: track.id,
      name: track.name,
      slug: track.slug,
      event_id: track.event_id
    }
  end
end
