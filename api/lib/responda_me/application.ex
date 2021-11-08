defmodule Responda.Me.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Responda.Me.Repo,
      # Start the Telemetry supervisor
      Responda.MeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Responda.Me.PubSub},
      # Start the Endpoint (http/https)
      Responda.MeWeb.Endpoint
      # Start a worker by calling: Responda.Me.Worker.start_link(arg)
      # {Responda.Me.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Responda.Me.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Responda.MeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
