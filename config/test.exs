import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :webhook_phx, WebhookPhx.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "webhook_phx_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :webhook_phx, WebhookPhxWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "3VWVWm97E8FwzF9FriK2QlJ0o61aT+Gj6G3ar4l0rIF2NshHw7KmvOxbGAunJ80T",
  server: false

# In test we don't send emails.
config :webhook_phx, WebhookPhx.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
