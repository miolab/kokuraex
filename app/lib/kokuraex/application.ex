defmodule Kokuraex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KokuraexWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:kokuraex, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Kokuraex.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Kokuraex.Finch},
      # Start a worker by calling: Kokuraex.Worker.start_link(arg)
      # {Kokuraex.Worker, arg},
      # Start to serve requests, typically the last entry
      KokuraexWeb.Endpoint,
      # Use cache
      {Cachex, name: :common_cache}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kokuraex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KokuraexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
