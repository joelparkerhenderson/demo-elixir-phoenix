defmodule DemoElixirPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :demo_elixir_phoenix,
    adapter: Ecto.Adapters.Postgres
end
