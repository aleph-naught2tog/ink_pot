defmodule Painter do
  def format(message, color, name) when is_binary(message) do
    apply(IO.ANSI, color, [])
    <> "[#{name}] "
    <> IO.ANSI.reset()
    <> message
  end
  def format(message, color, name), do: format(inspect(message, pretty: true), color, name)

  defmacro __using__(color: color, name: name) do
    quote do
      def log(message, label: label), do: log(message, label)
      def log(message) do
        message
        |> Painter.format(unquote(color), unquote(name))
        |> IO.puts()

        message
      end
      def log(message, label) do
        log("#{label}: " <> inspect(message))

        message
      end
    end
  end
end