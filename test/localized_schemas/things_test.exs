defmodule LocalizedSchemas.ThingsTest do
  use LocalizedSchemas.DataCase

  alias LocalizedSchemas.Things

  describe "things" do
    alias LocalizedSchemas.Things.Thing

    import LocalizedSchemas.ThingsFixtures

    @invalid_attrs %{name_en: nil, name_pt: nil, name_uk: nil}

    test "list_things/0 returns all things" do
      thing = thing_fixture()
      assert Things.list_things() == [thing]
    end

    test "get_thing!/1 returns the thing with given id" do
      thing = thing_fixture()
      assert Things.get_thing!(thing.id) == thing
    end

    test "create_thing/1 with valid data creates a thing" do
      valid_attrs = %{name_en: "some name_en", name_pt: "some name_pt", name_uk: "some name_uk"}

      assert {:ok, %Thing{} = thing} = Things.create_thing(valid_attrs)
      assert thing.name_en == "some name_en"
      assert thing.name_pt == "some name_pt"
      assert thing.name_uk == "some name_uk"
    end

    test "create_thing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Things.create_thing(@invalid_attrs)
    end

    test "update_thing/2 with valid data updates the thing" do
      thing = thing_fixture()
      update_attrs = %{name_en: "some updated name_en", name_pt: "some updated name_pt", name_uk: "some updated name_uk"}

      assert {:ok, %Thing{} = thing} = Things.update_thing(thing, update_attrs)
      assert thing.name_en == "some updated name_en"
      assert thing.name_pt == "some updated name_pt"
      assert thing.name_uk == "some updated name_uk"
    end

    test "update_thing/2 with invalid data returns error changeset" do
      thing = thing_fixture()
      assert {:error, %Ecto.Changeset{}} = Things.update_thing(thing, @invalid_attrs)
      assert thing == Things.get_thing!(thing.id)
    end

    test "delete_thing/1 deletes the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{}} = Things.delete_thing(thing)
      assert_raise Ecto.NoResultsError, fn -> Things.get_thing!(thing.id) end
    end

    test "change_thing/1 returns a thing changeset" do
      thing = thing_fixture()
      assert %Ecto.Changeset{} = Things.change_thing(thing)
    end
  end
end
