defmodule GenDispatcher.Adapter do
  @moduledoc """
  Behaviour module for dispatcher adapters
  """

  @doc """
  Dispatch event
  """
  @callback dispatch(Map.t) :: :ok | {:error, term}

  @doc false
  defmacro __using__(_opts) do
    quote do
      @behaviour GenDispatcher.Adapter
    end
  end

end
