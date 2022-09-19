defmodule Tokens do
  def echo(pid) do
    receive do
      message -> send(pid, message)
    end
  end

  def spawn_process(token) do
    spawn(Tokens, :echo, [self()])
    send(pid, token)
  end

  def echo_tokens(tokens) do
    Enum.each(tokens, &spawn_process/1)

    Enum.each(tokens, fn _ ->
      receive do
        msg -> IO.puts("Received on #{Time.utc_now()} for: #{msg}")
      end
    end)
  end
end

Tokens.echo_tokens(["Ken", "Winnie"])
