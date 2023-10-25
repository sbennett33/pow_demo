defmodule PowDemo.Repo do
  use Ecto.Repo,
    otp_app: :pow_demo,
    adapter: Ecto.Adapters.Postgres
end
