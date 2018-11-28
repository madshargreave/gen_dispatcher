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
    otp_app = Keyword.fetch!(opts, :otp_app)
    quote do
      alias GenDispatcher.Config

      def dispatch(event, opts) do
        config = Config.build!(__MODULE__, unquote(otp_app), opts)
        apply(config.adapter_module, :dispatch, [event, config.adapter_opts])
      end

    end
  end

end
