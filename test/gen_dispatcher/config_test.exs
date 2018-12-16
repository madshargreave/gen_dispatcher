defmodule GenDispatcher.ConfigTest do
  use ExUnit.Case

  defmodule TestDispatcher do
    use GenDispatcher, otp_app: :my_app
  end

  setup do
    opts = [adapter: {GenDispatcher.LocalDispatcher, log: false}]
    Application.put_env(:my_app, TestDispatcher, opts)
    {:ok, []}
  end

  test "it selects correct module" do
    config = GenDispatcher.Config.compile_config(TestDispatcher, [otp_app: :my_app])
    assert config.module == GenDispatcher.LocalDispatcher
    assert config.opts == [log: false]
  end

end
