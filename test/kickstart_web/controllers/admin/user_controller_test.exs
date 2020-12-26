defmodule KickstartWeb.Admin.UserControllerTest do
  use KickstartWeb.ConnCase

  alias Kickstart.Accounts
  import Kickstart.AccountsFixtures

  @create_attrs %{email: "some email", password: "some password", published_at: ~N[2010-04-17 14:00:00]}
  @update_attrs %{email: "some updated email", password: "some updated password", published_at: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{email: nil, password: nil, published_at: nil}

  setup do
    %{admin: admin_fixture()}
  end

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_user_path(conn, :index))
      assert html_response(conn, 200) =~ "Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_user_path(conn, :new))
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> post(Routes.admin_user_path(conn, :create), user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_user_path(conn, :show, id)

      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "User Details"
    end

    test "renders errors when data is invalid", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> post(Routes.admin_user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> put(Routes.admin_user_path(conn, :update, user), user: @update_attrs)
      assert redirected_to(conn) == Routes.admin_user_path(conn, :show, user)

      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_user_path(conn, :show, user))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> put(Routes.admin_user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> delete(Routes.admin_user_path(conn, :delete, user))
      assert redirected_to(conn) == Routes.admin_user_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_user_path(conn, :show, user)
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
