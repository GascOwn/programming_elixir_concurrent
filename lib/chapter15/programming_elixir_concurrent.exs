defmodule ProgrammingElixirConcurrent do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
        # tail-call optimization avoids infinite function calls by
        # simply going back to the beginning of the function without adding stack frames
        greet()
    end
  end
end

# Client
pid = spawn(ProgrammingElixirConcurrent, :greet, [])

# self() returns its caller's PID
send(pid, {self(), "World!"})

receive do
  {:ok, message} -> IO.puts(message)
end

send(pid, {self(), "Kermit!"})

receive do
  {:ok, message} -> IO.puts(message)
after
  500 -> IO.puts("The greeter has gone away")
end
