defmodule LocalizedSchemas.Repo do
  use Ecto.Repo,
    otp_app: :localized_schemas,
    adapter: Ecto.Adapters.Postgres
end
