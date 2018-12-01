defmodule GenDispatcherTest do
  use ExUnit.Case
  use GenDispatcher.Test

  defmodule TestDispatcher do
    use GenDispatcher,
      otp_app: :my_app,
      adapter: GenDispatcher.TestDispatcher
  end

  test "it dispatches event to current test process" do
    {:ok, _} = TestDispatcher.start_link
    TestDispatcher.dispatch(%{id: 1})
    assert_dispatched %{id: 1}
  end

end
