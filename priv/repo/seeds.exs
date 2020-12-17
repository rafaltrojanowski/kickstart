# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kickstart.Repo.insert!(%Kickstart.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Create Admin User
Kickstart.Accounts.create_user(%{
  email: "kickstart@admin.com",
  password: "password1234",
  admin: true
})
