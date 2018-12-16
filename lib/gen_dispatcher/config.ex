defmodule GenDispatcher.Config do
  @moduledoc """
  Module that handles resolving dispatcher configuration settings
  """
  defstruct [:module, :opts]

  def compile_config(module, opts \\ []) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    adapter = Application.get_env(otp_app, module)[:adapter] || Keyword.fetch!(opts, :adapter)

    case adapter do
      {module, opts} = adapter ->
        %__MODULE__{
          module: module,
          opts: opts
        }
      module when is_atom(module) ->
        %__MODULE__{
          module: module,
          opts: []
        }
    end
  end
end
