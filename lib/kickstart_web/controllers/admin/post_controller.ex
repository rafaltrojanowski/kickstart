defmodule KickstartWeb.Admin.PostController do
  use KickstartWeb, :controller


  alias Kickstart.Blog
  alias Kickstart.Blog.Post
  alias Kickstart.Accounts.User
  alias Kickstart.Repo


  plug(:put_layout, {KickstartWeb.LayoutView, "torch.html"})


  def index(conn, params) do
    case Blog.paginate_posts(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Posts. #{inspect(error)}")
        |> redirect(to: Routes.admin_post_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    users = Repo.all(User)
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"post" => post_params}) do
    users = Repo.all(User)

    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.admin_post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
      |> Repo.preload(:user)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    users = Repo.all(User)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)
    users = Repo.all(User)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.admin_post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.admin_post_path(conn, :index))
  end
end
