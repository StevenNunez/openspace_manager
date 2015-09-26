defmodule OpenspaceBackend.TrackTest do
  use OpenspaceBackend.ModelCase

  alias OpenspaceBackend.Track

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Track.changeset(%Track{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Track.changeset(%Track{}, @invalid_attrs)
    refute changeset.valid?
  end
end
