defmodule LocalizedSchemas.Things.Schema do
  defmacro __using__(opts) do
    locale = Keyword.get(opts, :locale, :en)

    quote do
      use Ecto.Schema
      import Ecto.Changeset

      schema "things" do
        field :name, :string, source: :"name_#{unquote(locale)}"

        timestamps(type: :utc_datetime)
      end

      def changeset(thing, attrs) do
        thing
        |> cast(attrs, [:name])
        |> validate_required([:name])
      end
    end
  end
end
