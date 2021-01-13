defmodule KickstartWeb.SocialAuthController do
  use KickstartWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias KickstartWeb.UserAuth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Kickstart.Accounts.find_or_create(auth) do
      {:ok, user} ->
        UserAuth.log_in_user(conn, user)

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
