defmodule DashboardTest do
  @moduledoc """
  Documentation for `DashboardTest`.
  """

  def run() do
    IO.puts("Press enter to stop\n")

    {:ok, pid} = DashboardTest.Render.start_link([])
    _ = IO.gets("")
    DashboardTest.Render.stop(pid)
  end
end
