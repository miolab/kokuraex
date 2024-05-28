defmodule Kokuraex.Repo do
  use Ecto.Repo,
    otp_app: :kokuraex,
    adapter: Ecto.Adapters.Postgres
end
