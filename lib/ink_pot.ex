defmodule InkPot do
  use Application
  use Painter, color: :cyan, name: "App"

  @moduledoc """
  Documentation for InkPot.
  """

  # has to start and spawn a process via a supervisor
  # and return its pid
  def start(_type, _args) do
    application_pid = self()
    log(application_pid, label: "started")
    children = [
      %{id: Ink, start: {Ink, :start_link, [application_pid]}}
    ]

    children
    |> InkPotSupervisor.start_link(application_pid, strategy: :one_for_one)
  end
end
