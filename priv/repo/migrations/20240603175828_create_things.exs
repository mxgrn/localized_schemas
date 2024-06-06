defmodule LocalizedSchemas.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things) do
      add :name_en, :string
      add :name_pt, :string
      add :name_uk, :string

      timestamps(type: :utc_datetime)
    end
  end
end
