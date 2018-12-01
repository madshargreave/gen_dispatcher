defmodule GenDispatcher.SyncDispatcher do
  @moduledoc """
  Dispatches events to a specific module or function

  ## Usage

      # config/config.exs
      config :my_app, MyApp.Dispatcher,
        adapter: {
          GenDispatcher.SyncDispatcher,
            callback: {MyEventHandler, :process, []}
        }
  """
  use GenDispatcher.Adapter

  @impl true
  def dispatch(event, state) do
    {:ok, state}
  end
end
