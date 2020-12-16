# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kickstart,
  ecto_repos: [Kickstart.Repo]

# Configures the endpoint
config :kickstart, KickstartWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9g+zSB+jRhoGRVbtdvkwqH/s64gXtnFSttTDyQ3wmga6Kp25xY5n9p/12/l1Ohr0",
  render_errors: [view: KickstartWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Kickstart.PubSub,
  live_view: [signing_salt: "ECXK5ckR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Torch Admin Dashboard
config :torch,
  otp_app: :kickstart,
  template_format: "eex" || "slime"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
