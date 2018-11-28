defmodule GenDispatcher.TestDispatcher do
  @moduledoc """
  Dispatcher that sends events to a parent test process
  """
  use GenDispatcher.Adapter

  @impl true
  def dispatch(event, opts \\ []) do
    parent_pid = Application.fetch_env!(:gen_dispatcher_test, :parent_pid)
    send(parent_pid, {:event, event})
    :ok
  end

end
