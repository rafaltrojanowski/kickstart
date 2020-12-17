defmodule Kickstart.Repo.Migrations.AddSocialAuthToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :provider, :string
      add :social_auth_uid, :string
      add :avatar, :string
    end
  end
end
