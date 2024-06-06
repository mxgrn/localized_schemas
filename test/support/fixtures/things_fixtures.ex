defmodule LocalizedSchemas.ThingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LocalizedSchemas.Things` context.
  """

  @doc """
  Generate a thing.
  """
  def thing_fixture(attrs \\ %{}) do
    {:ok, thing} =
      attrs
      |> Enum.into(%{
        name_en: "some name_en",
        name_pt: "some name_pt",
        name_uk: "some name_uk"
      })
      |> LocalizedSchemas.Things.create_thing()

    thing
  end
end
