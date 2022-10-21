defmodule WebhookPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      WebhookPhx.Repo,
      # Start the Telemetry supervisor
      WebhookPhxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WebhookPhx.PubSub},
      # Start the Endpoint (http/https)
      WebhookPhxWeb.Endpoint
      # Start a worker by calling: WebhookPhx.Worker.start_link(arg)
      # {WebhookPhx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebhookPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebhookPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
