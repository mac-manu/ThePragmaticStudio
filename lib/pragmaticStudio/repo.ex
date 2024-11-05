defmodule PragmaticStudio.Repo do
  use Ecto.Repo,
    otp_app: :pragmaticStudio,
    adapter: Ecto.Adapters.Postgres
end
