defmodule GenDispatcher.Test do
  @moduledoc """
  Test utilities for testing dispatcher integrations
  """
  import ExUnit.Assertions

  @doc """
  Imports GenDispatcher.Test

  `GenDispatcher.Test` and the `GenDispatcher.TestAdapter` work by sending a message to the
  current process when an event is dispatched.
  """
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case

      setup tags do
        if tags[:async] do
          raise """
          you cannot use GenDispatcher.Test shared mode with async tests.
          Set your test to [async: false]
          """
        else
          Application.put_env(:gen_dispatcher, :shared_test_process, self())
        end

        :ok
      end

      import GenDispatcher.Test
    end
  end

  @doc """
  Asserts that an event was dispatched using the test adapter
  """
  defmacro assert_dispatched(event) do
    quote do
      assert_receive {:event, unquote(event)}
    end
  end

  @doc """
  Refutes that an event was dispatched using the test adapter
  """
  defmacro refute_dispatched(event) do
    quote do
      refute_receive {:event, unquote(event)}
    end
  end
end
