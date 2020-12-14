defmodule Kickstart.Repo do
  use Ecto.Repo,
    otp_app: :kickstart,
    adapter: Ecto.Adapters.Postgres
end
