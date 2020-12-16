defmodule KickstartWeb.Admin.DashboardController do
  use KickstartWeb, :controller

  plug(:put_layout, {KickstartWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    render(conn, "index.html")
  end
end
