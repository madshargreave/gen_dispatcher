defmodule GenDispatcher.Test do
  @moduledoc """
  Test utilities for testing dispatcher integrations

  ## Usage

  Define a module that implements the test dispatcher dapter

    # tests/test_helper.exs
    defmodule TestDispatcher do
      use GenDispatcher.TestDispatcher, otp_app: :my_app
    end

    ## tests/dispatcher_test.exs
    defmodule MyApp.DispatcherTest do
      use ExUnit.Case

      setup do
        Application.put_env(:gen_dispatcher_test, :parent_pid, self())
        :ok
      end

      test "it dispatches event" do
        assert :ok = TestDispatcher.dispatch(%MyApp.Event{})
        assert_dispatched %MyApp.SomeEvent{}
      end
    end
  """
  import ExUnit.Case

  @doc """
  Asserts that an event was dispatched using the test adapter
  """
  defmacro assert_dispatched(event) do
    quote do
      assert_receive {:event, event}
    end
  end

end
