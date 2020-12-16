defmodule KickstartWeb.PostController do
  use KickstartWeb, :controller

  alias Kickstart.Blog

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    post = Blog.get_post!(slug)
    render(conn, "show.html", post: post)
  end
end
