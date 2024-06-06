# The following 3 are localized versions of Thing.
defmodule LocalizedSchemas.Things.En.Thing do
  use LocalizedSchemas.Things.Schema, locale: :en
end

defmodule LocalizedSchemas.Things.Uk.Thing do
  use LocalizedSchemas.Things.Schema, locale: :uk
end

defmodule LocalizedSchemas.Things.Pt.Thing do
  use LocalizedSchemas.Things.Schema, locale: :pt
end

defmodule LocalizedSchemas.Things.Thing do
  @moduledoc """
  This schema includes fields for all locales. Useful for forms, when we want to be able to edit all locales in one place.
  """
  use Ecto.Schema
  use Localized

  import Ecto.Changeset

  schema "things" do
    # This will create 3 fields, one per locale; see Localized.
    localized_field(:name, :string)

    timestamps(type: :utc_datetime)
  end

  def changeset(thing, attrs) do
    thing
    # see Localized
    |> cast(attrs, localized_fields([:name]))
    |> validate_required(localized_fields([:name]))
  end
end
