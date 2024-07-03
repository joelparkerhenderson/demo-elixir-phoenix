defmodule DemoElixirPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DemoElixirPhoenixWeb.Telemetry,
      DemoElixirPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:demo_elixir_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DemoElixirPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DemoElixirPhoenix.Finch},
      # Start a worker by calling: DemoElixirPhoenix.Worker.start_link(arg)
      # {DemoElixirPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      DemoElixirPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DemoElixirPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemoElixirPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
