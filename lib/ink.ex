defmodule Ink do
  use Painter, color: :light_yellow, name: "Ink"
  def start_link(app_id) do
    pid = self()
    log(pid, label: "started")
    log(app_id, label: "args")
    spawn Ink.listen(app_id)
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
      {:ok, ^app_id, {:LEFT, counter}} -> handle_left(app_id, counter)
      {:ok, ^app_id, {:RIGHT, counter}} -> handle_right(app_id, counter)
      {:ok, ^app_id, message} -> handle_message(app_id, message)
    end
  end

  def handle_left(app_id, counter) do
    log(counter, label: "got")
    wait(app_id, {:DID_LEFT, counter})
  end

  def handle_right(app_id, counter) do
    log(counter, label: "got")
    wait(app_id, {:DID_RIGHT, counter})
  end

  def handle_message(app_id, message) do
    log(message, label: "got")
    wait(app_id, message)
  end
end