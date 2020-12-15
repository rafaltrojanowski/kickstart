defmodule KickstartWeb.LayoutView do
  use KickstartWeb, :view

  def gravatar(email) do
    hash = email
      |> String.trim()
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    img = "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
    img_tag(img, class: "rounded-circle", width: "40", height: "40")
  end
end
