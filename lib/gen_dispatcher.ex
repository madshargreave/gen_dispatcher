defmodule GenDispatcher do
  @moduledoc """
  Documentation for GenDispatcher.

  ## Usage

      defmodule MyApp.Dispatcher do
        use GenDispatcher, otp_app: :my_app
      end

      # config/config.exs
      config :my_app, MyApp.Dispatcher,
        adapter: {GenDispatcher.RedisAdapter, [topic: "my-topic"]}
  """

  @doc false
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use GenServer
      alias GenDispatcher.Serdes

      config = GenDispatcher.Config.compile_config(__MODULE__, opts)
      @config config

      def __config__, do: @config

      def child_spec(opts) do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, [opts]},
          type: :worker
        }
      end

      def start_link(opts \\ []) do
        name = Keyword.get(opts, :name, __MODULE__)
        GenServer.start_link(__MODULE__, opts, name: name)
      end

      def dispatch(topic, events, opts \\ [])
      def dispatch(topic, events, opts) when is_list(events) do
          for event <- events, do: dispatch(topic, event, opts)
          :ok
      end
      def dispatch(topic, event, opts) do
        GenServer.call(__MODULE__, {:dispatch, topic, event, opts})
      end

      @impl true
      def init(opts) do
        opts = Keyword.merge(__config__().opts, opts)
        __config__().module.init(opts)
      end

      @impl true
      def handle_call({:dispatch, topic, event, opts}, _from, state) do
        opts = Keyword.merge(__config__().opts, opts)
        event = Serdes.encode(event)
        {:ok, state} = __config__().module.dispatch(topic, event, state)
        {:reply, :ok, state}
      end
    end
  end
end
