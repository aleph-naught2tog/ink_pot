defmodule InkPotSupervisor do
  use Supervisor
  @compile :debug_info

  def start_link(_children, _options) do
    current_pid = self()
    spawn(fn -> send(current_pid, {self(), "hello"}) end)
  end

  @impl true
  def init(options) do
    IO.inspect(options, label: "options")
  end
end