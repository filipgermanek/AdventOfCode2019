defmodule AdventOfCode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    # List all child processes to be supervised
    children = [
      worker(AdventOfCode.Producer, [0]),
      worker(AdventOfCode.ProducerConsumer, []),
      worker(AdventOfCode.Consumer, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AdventOfCode.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
