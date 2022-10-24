defmodule WebhookPhx.Error do
  @key [:status, :message]

  @enforce_keys @key

  defstruct @key

  def build(status, message) do
    %__MODULE__{
      status: status,
      message: message
    }
  end
end
