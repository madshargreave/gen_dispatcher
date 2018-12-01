defmodule GenDispatcherTest do
  use ExUnit.Case
  use GenDispatcher.Test

  defmodule TestDispatcher do
    use GenDispatcher,
      otp_app: :my_app,
      adapter: GenDispatcher.TestDispatcher
  end

  setup do
    {:ok, _} = TestDispatcher.start_link
    {:ok, []}
  end

  test "it dispatches event to current test process" do
    TestDispatcher.dispatch(%{id: 1})
    assert_dispatched %{id: 1}
  end

  test "it refutes events if they have not been dispatched" do
    TestDispatcher.dispatch(%{id: 1})
    refute_dispatched %{id: 2}
  end

end
