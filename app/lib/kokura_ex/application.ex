defmodule KokuraEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KokuraExWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: KokuraEx.PubSub},
      # Start the Endpoint (http/https)
      KokuraExWeb.Endpoint
      # Start a worker by calling: KokuraEx.Worker.start_link(arg)
      # {KokuraEx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KokuraEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KokuraExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
