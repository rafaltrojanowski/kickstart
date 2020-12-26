defmodule KickstartWeb.Admin.PostControllerTest do
  use KickstartWeb.ConnCase

  alias Kickstart.Blog
  alias Kickstart.Accounts
  import Kickstart.AccountsFixtures

  @create_attrs %{body: "some body", published: true, published_at: ~N[2010-04-17 14:00:00], slug: "some slug", title: "some title", views: 42}
  @update_attrs %{body: "some updated body", published: false, published_at: ~N[2011-05-18 15:01:01], slug: "some updated slug", title: "some updated title", views: 43}
  @invalid_attrs %{body: nil, published: nil, published_at: nil, slug: nil, title: "some-title", views: nil}

  @user_attrs %{email: "test@user.com", password: "password1234"}

  setup do
    %{admin: admin_fixture()}
  end

  def fixture(:post) do
    {:ok, user} = Accounts.create_user(@user_attrs)
    {:ok, post} = Blog.create_post(Map.merge(@create_attrs, %{user_id: user.id}))
    post
  end

  describe "index" do
    test "lists all posts", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_post_path(conn, :index))
      assert html_response(conn, 200) =~ "Posts"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_post_path(conn, :new))
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn, admin: admin} do
      {:ok, user} = Accounts.create_user(@user_attrs)

      conn =
      build_conn()
      |> log_in_user(admin)
      |> post(Routes.admin_post_path(conn, :create), post: Map.merge(@create_attrs, %{user_id: user.id}))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_post_path(conn, :show, id)

      conn = get conn, Routes.admin_post_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Post Details"
    end

    test "renders errors when data is invalid", %{conn: conn, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> post(Routes.admin_post_path(conn, :create), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_post_path(conn, :edit, post))
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> put(Routes.admin_post_path(conn, :update, post), post: @update_attrs)

      assert redirected_to(conn) == Routes.admin_post_path(conn, :show, "some-updated-title")

      conn =
      build_conn()
      |> log_in_user(admin)
      |> get(Routes.admin_post_path(conn, :show, "some-updated-title"))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> put(Routes.admin_post_path(conn, :update, post), post: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post, admin: admin} do
      conn =
      build_conn()
      |> log_in_user(admin)
      |> delete(Routes.admin_post_path(conn, :delete, post))

      assert redirected_to(conn) == Routes.admin_post_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_post_path(conn, :show, post)
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
