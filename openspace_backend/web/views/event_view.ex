defmodule OpenspaceBackend.EventView do
  use OpenspaceBackend.Web, :view

  def render("index.json", %{events: events}) do
    %{events: render_many(events, OpenspaceBackend.EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{event: render_one(event, OpenspaceBackend.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      slug_name: event.slug_name
    }
  end
end
