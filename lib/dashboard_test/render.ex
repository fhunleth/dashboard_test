defmodule DashboardTest.Render do
  use GenServer

  @height 10

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec stop(GenServer.server()) :: :ok
  def stop(server) do
    GenServer.stop(server)
  end

  @impl GenServer
  def init(_args) do
    _ = :timer.send_interval(1000, :tick)

    draw()
    |> IO.write()

    {:ok, :no_state}
  end

  @impl GenServer
  def handle_info(:tick, state) do
    [
      erase(),
      draw()
    ]
    |> IO.write()

    {:noreply, state}
  end

  defp draw() do
    for i <- 1..@height do
      ["#{i}:", :binary.copy(" ", i * 3), inspect(NaiveDateTime.local_now()), "\n"]
    end
  end

  defp erase() do
    [
      IO.ANSI.cursor_up(@height),
      for(_ <- 1..@height, do: [IO.ANSI.clear_line(), "\n"]),
      IO.ANSI.cursor_up(@height)
    ]
  end
end
