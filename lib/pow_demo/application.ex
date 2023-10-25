defmodule PowDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PowDemoWeb.Telemetry,
      PowDemo.Repo,
      {DNSCluster, query: Application.get_env(:pow_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PowDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PowDemo.Finch},
      # Start a worker by calling: PowDemo.Worker.start_link(arg)
      # {PowDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      PowDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PowDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PowDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
