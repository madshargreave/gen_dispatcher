defmodule GenDispatcher.Adapter do
  @moduledoc """
  Behaviour module for dispatcher adapters
  """

  @doc """
  Dispatch event
  """
  @callback dispatch(event :: Map.t, state :: Map.t) :: :ok | {:error, term}

  @doc false
  defmacro __using__(_opts) do
    quote do
      @behaviour GenDispatcher.Adapter
    end
  end

end
