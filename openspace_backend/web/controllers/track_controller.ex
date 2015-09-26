defmodule OpenspaceBackend.TrackController do
  use OpenspaceBackend.Web, :controller

  alias OpenspaceBackend.Track

  plug :scrub_params, "track" when action in [:create, :update]

  def index(conn, %{"event_id" => event_id}) do
    tracks = Repo.all(Track.find_by_event_id(event_id))
    render(conn, "index.json", tracks: tracks)
  end

  def create(conn, %{"track" => track_params}) do
    changeset = Track.changeset(%Track{}, track_params)

    case Repo.insert(changeset) do
      {:ok, track} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", track_path(conn, :show, track))
        |> render("show.json", track: track)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenspaceBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    track = Repo.get_by!(Track, slug: slug)
    render conn, "show.json", track: track
  end

  def update(conn, %{"slug" => slug, "track" => track_params, "event_id" => event_id}) do
    track = Repo.get_by!(Track, slug: slug)
    changeset = Track.changeset(track, track_params)

    case Repo.update(changeset) do
      {:ok, track} ->
        render(conn, "show.json", track: track)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenspaceBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug, "event_id" => event_id}) do
    track = Repo.get_by!(Track, slug: slug)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(track)

    send_resp(conn, :no_content, "")
  end
end
