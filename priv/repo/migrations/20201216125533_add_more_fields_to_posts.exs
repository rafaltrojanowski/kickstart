defmodule Kickstart.Repo.Migrations.AddMoreFieldsToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, references(:users), null: false
      add :published_at, :naive_datetime
      add :published, :boolean
      add :views, :integer, default: 0, null: false
    end
  end
end
