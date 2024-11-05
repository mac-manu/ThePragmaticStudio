defmodule PragmaticStudio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PragmaticStudioWeb.Telemetry,
      PragmaticStudio.Repo,
      {DNSCluster, query: Application.get_env(:pragmaticStudio, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PragmaticStudio.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PragmaticStudio.Finch},
      # Start a worker by calling: PragmaticStudio.Worker.start_link(arg)
      # {PragmaticStudio.Worker, arg},
      # Start to serve requests, typically the last entry
      PragmaticStudioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PragmaticStudio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PragmaticStudioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
