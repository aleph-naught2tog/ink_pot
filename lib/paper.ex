defmodule Paper do
  use Painter, color: :green, name: "Paper"

  def start_link(app_id) do
    pid = self()
    log(pid, label: "started")
    log(app_id, label: "args")

    spawn Paper.listen(app_id)
    {:ok, pid}
  end

  def listen(app_id) do
    fn ->
      wait(app_id, 0)
    end
  end

  def wait(app_id, input) do
    send(app_id, {:ok, self(), input})
    receive do
      {:ok, ^app_id, {:UP, counter}} -> handle_up(app_id, counter)
      {:ok, ^app_id, {:DOWN, counter}} -> handle_down(app_id, counter)
      {:ok, ^app_id, message} -> handle_message(app_id, message)
    end
  end

  defp handle_up(app_id, counter) do
    log(counter, label: "got")
    wait(app_id, counter + 1)
  end

  defp handle_message(app_id, message) do
    log(message, label: "got")
    wait(app_id, message)
  end

  defp handle_down(app_id, counter) do
    log(counter, label: "got")
    wait(app_id, counter - 1)
  end
end