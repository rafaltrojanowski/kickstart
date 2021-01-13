defmodule Kickstart.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string
    field :slug, :string
    field :published_at, :naive_datetime
    field :published, :boolean
    field :views, :integer

    belongs_to :user, Kickstart.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    attrs = Map.merge(attrs, slugify_title(attrs))

    post
    |> cast(attrs, [:title, :body, :slug, :user_id, :published_at, :published])
    |> validate_required([:title, :body, :user_id])
  end

  defp slugify_title(%{"title" => title}) do
    slug =
      title
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9\s-]/, "")
      |> String.replace(~r/(\s|-)+/, "-")

    %{"slug" => slug}
  end

  defp slugify_title(_params) do
    %{}
  end
end

defimpl Phoenix.Param, for: Kickstart.Blog.Post do
  def to_param(%{slug: slug}) do
    "#{slug}"
  end
end
