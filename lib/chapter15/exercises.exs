defmodule Chapter15.Exercises do
  import :timer, only: [sleep: 1]

  def send_message(pid, message) do
    send(pid, message)
    exit(:dead)
  end

  def run(messages) do
    Process.flag(:trap_exit, true)
    spawn_link(Chapter15.Exercises, :send_message, [self(), messages])
    sleep(500)

    receive do
      message -> IO.puts(message)
    end
  end
end

defmodule Chapter15.ExercisesMonitor do
  import :timer, only: [sleep: 1]

  def send_message(pid, message) do
    send(pid, message)
    exit(:dead)
  end

  def run(messages) do
    res = spawn_monitor(Chapter15.ExercisesMonitor, :send_message, [self(), messages])
    IO.puts(inspect(res))
    sleep(500)

    receive do
      message -> IO.puts(message)
    end
  end
end
