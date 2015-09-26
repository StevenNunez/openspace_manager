defmodule OpenspaceBackend.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :slug, :string

      timestamps
    end

    create index(:events, [:slug])
  end
end
