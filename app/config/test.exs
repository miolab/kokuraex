import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kokuraex, KokuraexWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "qHjSfUiW1aXu7Aj88v9X0uheFIZhm6inGqkXnVGt5jt5kOtG1cDAl2i8OxRc4b3+",
  server: false

# In test we don't send emails.
config :kokuraex, Kokuraex.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
