defmodule Drawtoo.Repo do
  use Ecto.Repo,
    otp_app: :drawtoo,
    adapter: Ecto.Adapters.Postgres
end
