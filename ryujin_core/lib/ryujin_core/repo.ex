defmodule RyujinCore.Repo do
  use Ecto.Repo,
    otp_app: :ryujin_core,
    adapter: Ecto.Adapters.Postgres
end
