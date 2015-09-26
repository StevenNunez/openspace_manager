defmodule OpenspaceBackend.Track do
  use OpenspaceBackend.Web, :model
  before_insert :set_slug
  before_update :set_slug

  schema "tracks" do
    field :name, :string
    field :slug, :string
    belongs_to :event, OpenspaceBackend.Event

    timestamps
  end

  @required_fields ~w(name event_id)
  @optional_fields ~w(slug)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def find_by_event_id(event_id) do
    from t in __MODULE__, where: t.event_id == ^event_id
  end

  def find_by_slug(slug) do
    from e in __MODULE__, where: e.slug == ^slug
  end

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
