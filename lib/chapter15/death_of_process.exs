defmodule Link do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    spawn(Link, :sad_function, [])

    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
    after
      1000 ->
        IO.puts("Nothing happened here.")
    end
  end
end

# Abnormally aborted child processess kill the entire application
# The death of another process can be handled

defmodule Link2 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link, :sad_function, [])

    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
    after
      1000 ->
        IO.puts("Nothing happened here.")
    end
  end
end
