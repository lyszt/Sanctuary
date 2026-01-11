defmodule RyujinCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RyujinCoreWeb.Telemetry,
      RyujinCore.Repo,
      {DNSCluster, query: Application.get_env(:ryujin_core, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RyujinCore.PubSub},
      # Start a worker by calling: RyujinCore.Worker.start_link(arg)
      # {RyujinCore.Worker, arg},
      # Start to serve requests, typically the last entry
      RyujinCoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RyujinCore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RyujinCoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
