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

      {otp_app, adapter} = GenDispatcher.Config.compile_config(__MODULE__, opts)
      @otp_app otp_app
      @adapter adapter

      def __adapter__, do: @adapter

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

      def dispatch(event, opts \\ []) do
        GenServer.call(__MODULE__, {:dispatch, event, opts})
      end

      @impl true
      def init(_opts) do
        state = %{}
        {:ok, state}
      end

      @impl true
      def handle_call({:dispatch, event, opts}, _from, state) do
        case __adapter__().adapter_module.dispatch(event, state) do
          {:ok, state} ->
            {:reply, :ok, state}
        end
      end
    end
  end
end
