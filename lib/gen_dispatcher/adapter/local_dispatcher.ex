defmodule GenDispatcher.LocalDispatcher do
  @moduledoc """
  Dispatcher that logs out events to stdout
  """
  require Logger
  use GenDispatcher.Adapter

  @impl true
  def dispatch(event, opts \\ []) do
    Logger.info "Dispatching event: #{inspect(event)}"
    :ok
  end

end
