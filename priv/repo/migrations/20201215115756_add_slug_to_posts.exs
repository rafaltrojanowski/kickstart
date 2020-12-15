defmodule Kickstart.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :slug, :string
    end

    create index(:posts, [:slug], unique: true)
  end
end
