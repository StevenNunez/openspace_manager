defmodule OpenspaceBackend.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :name, :string
      add :slug, :string
      add :event_id, references(:events)

      timestamps
    end
    create index(:tracks, [:event_id])

  end
end
