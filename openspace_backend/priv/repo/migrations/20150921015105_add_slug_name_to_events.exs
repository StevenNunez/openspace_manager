defmodule OpenspaceBackend.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :slug_name, :string
    end

  end
end
