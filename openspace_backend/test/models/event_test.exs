defmodule OpenspaceBackend.EventTest do
  use OpenspaceBackend.ModelCase

  alias OpenspaceBackend.Event
  alias OpenspaceBackend.Repo

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "dasherizes name for slug" do
    attrs = %{name: "The greatest conference"}
    changeset = Event.changeset(%Event{}, attrs)
    {:ok, event} = Repo.insert(changeset)
    event_from_db = Repo.get!(Event, event.id)
    assert event_from_db.slug == "the-greatest-conference"
  end


end
