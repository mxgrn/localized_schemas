defmodule Localized do
  @moduledoc """
  This should be extracted into a library.
  """

  defmacro localized_field(name, type, opts \\ []) do
    quote do
      Application.compile_env(:localized_schemas, LocalizedSchemasWeb.Gettext)[:locales]
      |> Enum.each(&field(:"#{unquote(name)}_#{&1}", unquote(type), unquote(opts)))
    end
  end

  def localized_fields(fields) do
    fields
    |> Enum.flat_map(fn field ->
      (Application.get_env(:localized_schemas, LocalizedSchemasWeb.Gettext)[:locales] || [])
      |> Enum.map(&:"#{field}_#{&1}")
    end)
  end

  defmacro __using__(_opts) do
    quote do
      require Localized
      import Localized
    end
  end
end
