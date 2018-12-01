defmodule GenDispatcher.Config do
  @moduledoc """
  Module that handles resolving dispatcher configuration settings
  """
  defstruct [:adapter_module, :adapter_opts]

  def compile_config(module, opts \\ []) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    adapter = Application.get_env(otp_app, module)[:adapter] || Keyword.get(opts, :adapter)

    case adapter do
      {module, adapter_opts} = adapter ->
        {otp_app, %__MODULE__{
          adapter_module: module,
          adapter_opts: Keyword.merge(opts, adapter_opts)
        }}
      module when is_atom(module) ->
        {otp_app, %__MODULE__{
          adapter_module: module,
          adapter_opts: opts
        }}
    end
  end

end
