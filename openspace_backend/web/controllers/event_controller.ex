defmodule OpenspaceBackend.EventController do
  use OpenspaceBackend.Web, :controller

  alias OpenspaceBackend.Event

  plug :scrub_params, "event" when action in [:create, :update]

  def index(conn, _params) do
    events = Repo.all(Event)
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    changeset = Event.changeset(%Event{}, event_params)

    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", event_path(conn, :show, event))
        |> render("show.json", event: event)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenspaceBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    event = Repo.get_by!(Event, slug: slug) |> Repo.preload :tracks
    render conn, "show.json", event: event
  end

  def update(conn, %{"slug" => slug, "event" => event_params}) do
    event = Repo.get_by!(Event, slug: slug)
    changeset = Event.changeset(event, event_params)

    case Repo.update(changeset) do
      {:ok, event} ->
        render(conn, "show.json", event: event)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenspaceBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    event = Repo.get_by!(Event, slug: slug)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(event)

    send_resp(conn, :no_content, "")
  end
end
