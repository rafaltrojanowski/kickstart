defmodule KickstartWeb.PostController do
  use KickstartWeb, :controller

  alias Kickstart.Blog
  alias Kickstart.Blog.Post
  alias Kickstart.Repo

  import Ecto.Query

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    post = Blog.get_post!(slug)
    |> inc_page_views()

    render(conn, "show.html", post: post)
  end

  def inc_page_views(%Post{} = post) do
    {1, [%Post{views: views}]} =
      from(p in Post, where: p.id == ^post.id, select: [:views])
      |> Repo.update_all(inc: [views: 1])

    put_in(post.views, views)
  end
end
