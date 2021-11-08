defmodule Responda.Me.Repo do
  use Ecto.Repo,
    otp_app: :responda_me,
    adapter: Ecto.Adapters.Postgres
end
