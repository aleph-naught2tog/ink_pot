defmodule InkPotSupervisor do
  use Supervisor
  use Painter, color: :magenta, name: "Sup"
  @compile :debug_info

  def start_link(children, application_pid, _options) do
    supervisor_pid = self()
    log(supervisor_pid, label: "started")
    log(application_pid, label: "input PID")

    {:ok, child_pid} = Supervisor.start_link(children, strategy: :one_for_one)
    block()
    log(child_pid, label: "child")

    {:ok, child_pid}
  end

  def block(:halt), do: {:ok, self()}
  def block() do
    receive do
      {:ok, return_address, message} ->
        log(message, label: "got")
        send(return_address, {:ok, self(), message})
        block()
    end
  end

  @impl true
  def init(options) do
    log(options, label: "options")
  end
end