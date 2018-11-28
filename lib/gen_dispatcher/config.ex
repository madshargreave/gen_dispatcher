defmodule GenDispatcher.Config do
  @moduledoc """
  Module that handles resolving dispatcher configuration settings
  """
  defstruct [:adapter_module, :adapter_opts]

  def build!(module, otp_app, dynamic_opts \\ []) do
    case Application.fetch_env!(unquote(otp_app), module, :adapter) do
      {module, opts} = adapter ->
        %__MODULE__{
          adapter_module: module,
          adapter_opts: Keyword.merge(opts, dynamic_opts)
        }
      module when is_term(module) ->
        %__MODULE__{
          adapter_module: module,
          adapter_opts: dynamic_opts
        }
    end
  end

end
