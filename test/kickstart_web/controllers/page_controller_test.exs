defmodule KickstartWeb.PageControllerTest do
  use KickstartWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Kickstart · Phoenix Framework"
  end
end
