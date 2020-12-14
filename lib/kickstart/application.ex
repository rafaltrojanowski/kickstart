defmodule Kickstart.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Kickstart.Repo,
      # Start the Telemetry supervisor
      KickstartWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kickstart.PubSub},
      # Start the Endpoint (http/https)
      KickstartWeb.Endpoint
      # Start a worker by calling: Kickstart.Worker.start_link(arg)
      # {Kickstart.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kickstart.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KickstartWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
