defmodule Kickstart.BlogTest do
  use Kickstart.DataCase

  alias Kickstart.Blog
  alias Kickstart.Accounts

  describe "posts" do
    alias Kickstart.Blog.Post

    @valid_attrs %{body: "some body", title: "some title", slug: "test-slug"}
    @update_attrs %{body: "some updated body", title: "some updated title", slug: "updated-slug"}
    @invalid_attrs %{body: nil, title: nil, slug: nil}

    def user_fixture(_attrs \\ %{}) do
      {:ok, user} =
        %{email: "test@user.com", password: "password1234"}
        |> Accounts.create_user()
      user
    end

    def post_fixture(attrs \\ %{}) do
      user = user_fixture()
      {:ok, post} =
        attrs
        |> Enum.into(Map.merge(@valid_attrs, %{user_id: user.id}))
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.slug) == post
    end

    test "create_post/1 with valid data creates a post" do
      user = user_fixture()
      assert {:ok, %Post{} = post} = Blog.create_post(Map.merge(@valid_attrs, %{user_id: user.id}))
      assert post.body == "some body"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.slug)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.slug) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
