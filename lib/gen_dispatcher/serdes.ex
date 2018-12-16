defmodule GenDispatcher.Serdes do
  @moduledoc """
  Serialisation and deserialisation using Erlang term format
  """

  def encode(event) do
    :erlang.term_to_binary(event)
  end

  def decode(binary) do
    :erlang.binary_to_term(binary)
  end

end
