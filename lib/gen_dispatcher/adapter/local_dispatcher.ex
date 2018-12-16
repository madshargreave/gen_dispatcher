defmodule GenDispatcher.LocalDispatcher do
  @moduledoc """
  Dispatcher that logs out events to stdout
  """
  require Logger
  use GenDispatcher.Adapter

  @impl true
  def init(opts) do
    {:ok, :no_state}
  end

  @impl true
  def dispatch(topic, event, state) do
    Logger.info("Dispatching event: #{inspect(event)}")
    {:ok, state}
  end
end
