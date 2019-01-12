defmodule GenDispatcher.Config do
  @moduledoc """
  Module that handles resolving dispatcher configuration settings
  """
  defstruct [:module, :opts]

  def compile_config(module, opts \\ []) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    adapter = Application.get_env(otp_app, module)[:adapter] || Keyword.get(opts, :adapter)

    if !adapter do
      raise "[GenDispatcher] No adapter specified"
    end

    case adapter do
      {module, opts} = adapter ->
        global_adapter_opts = Application.get_env(otp_app, module, [])
        opts = Keyword.merge(opts, global_adapter_opts)
        %__MODULE__{
          module: module,
          opts: opts
        }
      module when is_atom(module) ->
        global_adapter_opts = Application.get_env(otp_app, module, [])
        opts = Keyword.merge(opts, global_adapter_opts)
        %__MODULE__{
          module: module,
          opts: []
        }
    end
  end
end
