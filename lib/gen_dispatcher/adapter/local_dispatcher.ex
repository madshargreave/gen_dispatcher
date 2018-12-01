defmodule GenDispatcher.LocalDispatcher do
  @moduledoc """
  Dispatcher that logs out events to stdout
  """
  require Logger
  use GenDispatcher.Adapter

  @impl true
  def dispatch(event, state) do
    Logger.info("Dispatching event: #{inspect(event)}")
    {:ok, state}
  end
end
