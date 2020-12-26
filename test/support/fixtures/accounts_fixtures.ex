defmodule Kickstart.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kickstart.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        password: valid_user_password(),
      })
      |> Kickstart.Accounts.register_user()

    user
  end

  def admin_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        password: valid_user_password()
      })
      |> Kickstart.Accounts.register_user()

    {:ok, admin} = Kickstart.Accounts.update_user(admin, %{admin: true, password: "password1234"})

    admin
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
