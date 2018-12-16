defmodule GenDispatcher.TestDispatcher do
  @moduledoc """
  Dispatcher that sends events to a parent test process
  """
  use GenDispatcher.Adapter

  @impl true
  def init(opts) do
    {:ok, :no_state}
  end

  @impl true
  def dispatch(topic, event, state) do
    send(test_process(), {:event, topic, event})
    {:ok, state}
  end

  defp test_process do
    Application.fetch_env!(:gen_dispatcher, :shared_test_process)
  end
end
