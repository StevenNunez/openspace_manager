defmodule OpenspaceBackend.Event do
  use OpenspaceBackend.Web, :model
  before_insert :set_slug
  before_update :set_slug

  schema "events" do
    field :name, :string
    field :slug, :string
    has_many :tracks, OpenspaceBackend.Track

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(slug)

  def find_by_slug(slug) do
    from e in __MODULE__,
    where: e.slug == ^slug,
    preload: :tracks
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  defp set_slug(changeset) do
    slug = get_change(changeset, :name, "")
    |> String.replace(~r/\s+/, "-")
    |> String.downcase
    put_change(changeset, :slug, slug)
  end
end
