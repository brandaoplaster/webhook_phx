defmodule WebhookPhx.Repo do
  use Ecto.Repo,
    otp_app: :webhook_phx,
    adapter: Ecto.Adapters.Postgres
end
