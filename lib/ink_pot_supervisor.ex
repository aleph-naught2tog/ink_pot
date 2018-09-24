defmodule InkPotSupervisor do
  use Supervisor
  use Painter, color: :magenta, name: "Sup"
  @compile :debug_info

  def start_link(children, application_pid, _options) do
    supervisor_pid = self()
    log(supervisor_pid, label: "started")
    log(application_pid, label: "input PID")

    {:ok, child_pid} = Supervisor.start_link(children, strategy: :one_for_one)
    block(0)
    log(child_pid, label: "child")

    {:ok, child_pid}
  end

  def block(:halt), do: {:ok, self()}
  def block(count) when is_integer(count) and rem(count, 4) === 0 do
    receive do
      {:ok, return_address, message} ->
        log(message, label: "got")
        send(return_address, {:ok, self(), {:UP, count |> rem(80)}})
        block(count + 1)
    end
  end

  def block(count) when is_integer(count) and rem(count, 4) === 1 do
    receive do
      {:ok, return_address, message} ->
        log(message, label: "got")
        send(return_address, {:ok, self(), {:DOWN, count |> rem(80)}})
        block(count + 1)
    end
  end

  def block(count) when is_integer(count) and rem(count, 2) === 0 do
    receive do
      {:ok, return_address, message} ->
        log(message, label: "got")
        send(return_address, {:ok, self(), {:RIGHT, count |> rem(80)}})
        block(count + 1)
    end
  end

  def block(count) when is_integer(count) and rem(count, 2) === 1 do
    receive do
      {:ok, return_address, message} ->
        log(message, label: "got")
        send(return_address, {:ok, self(), {:LEFT, count |> rem(80)}})
        block(count + 1)
    end
  end

  @impl true
  def init(options) do
    log(options, label: "options")
  end
end