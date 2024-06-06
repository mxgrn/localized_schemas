defmodule LocalizedSchemas.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LocalizedSchemasWeb.Telemetry,
      LocalizedSchemas.Repo,
      {DNSCluster, query: Application.get_env(:localized_schemas, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LocalizedSchemas.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LocalizedSchemas.Finch},
      # Start a worker by calling: LocalizedSchemas.Worker.start_link(arg)
      # {LocalizedSchemas.Worker, arg},
      # Start to serve requests, typically the last entry
      LocalizedSchemasWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LocalizedSchemas.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LocalizedSchemasWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
