defmodule InkPot do
  use Application

  @moduledoc """
  Documentation for InkPot.
  """

  @doc """
  Hello world.
  ## Examples
      iex> InkPot.hello()
      :world
  """
  def hello do
    :world
  end

  # has to start and spawn a process via a supervisor
  # and return its pid
  def start(type, args) do
    IO.inspect(type, label: "type")
    IO.inspect(args, label: "args")
    children = [
      %{id: Ink, start: {Ink, :start_link, [[]]}}
    ]

    children
    |> InkPotSupervisor.start_link(strategy: :one_for_one)
    |> do_start()
  end

  defp do_start(pid) when is_pid(pid), do: {:ok, pid}
  defp do_start(pid) do
    exit(1)
  end
end
