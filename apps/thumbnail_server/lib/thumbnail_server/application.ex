defmodule ThumbnailServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {DynamicSupervisor, name: ThumbnailServer.StoreSupervisor, strategy: :one_for_one},
      {Task.Supervisor, name: ThumbnailServer.WorkerSupervisor},
      {ThumbnailServer.Receptor, name: ThumbnailServer.Receptor}
    ]

    opts = [strategy: :one_for_one, name: ThumbnailServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
