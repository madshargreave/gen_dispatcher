defmodule GenDispatcher do
  @moduledoc """
  Documentation for GenDispatcher.

  ## Usage

      defmodule MyApp.Dispatcher do
        use GenDispatcher, otp_app: :my_app
      end

      # config/config.exs
      config :my_app, MyApp.Dispatcher,
        adapter: {
          GenDispatcher.RedisAdapter,
          [
            topic: "my-topic"
          ]
        }
  """

  @doc false
  defmacro __using__(opts) do
    {adapter_module, adapter_opts} = Keyword.fetch!(opts, :adapter)
    quote do

      def dispatch(events, opts) do
        opts =
          unquote(adapter_opts)
          |> Keyword.merge(opts)

        apply(
          unquote(adapter_module),
          :dispatch,
          [events, opts]
        )
      end

    end
  end

end
