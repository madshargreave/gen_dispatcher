defmodule GenDispatcher.RedisDispatcher do
  @moduledoc """
  Dispatcher that logs out events to stdout
  """
  require Logger
  use GenDispatcher.Adapter

  defmodule State do
    @moduledoc false
    defstruct [:conn]
  end

  @impl true
  def init(opts) do
    host = Keyword.get(opts, :host, "localhost")
    port = Keyword.get(opts, :port, 6379)
    {:ok, conn} = Redix.start_link(host: host, port: port)
    state = %State{conn: conn}
    {:ok, state}
  end

  @impl true
  def dispatch(topic, event, state) do
    commands = [["XADD", topic, "*", "value", event]]
    Redix.pipeline!(state.conn, commands)
    {:ok, state}
  end

end
