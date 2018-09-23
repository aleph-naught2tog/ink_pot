defmodule Ink do
  use Painter, color: :light_yellow, name: "Ink"

  def start_link(app_id) do
    pid = self()
    log(pid, label: "started")
    log(app_id, label: "args")

    {:ok, pid}
  end

  def init(opts) do
    log(opts)
  end
end