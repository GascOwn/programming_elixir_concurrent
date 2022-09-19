# Monitoring lets a process spawn another and be notified of its termination
# But without the reverse notification

defmodule Monitor1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor1, :sad_function, [])
    IO.puts(inspect(res))

    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
    after
      1000 -> IO.puts("Nothing happened as far as I am concerned")
    end
  end
end

Monitor1.run()

# Links are preferred when the failure of one process should termine another
# Monitors are used to when a process needs to know when another exits for any reason
