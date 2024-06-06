defmodule LocalizedSchemasWeb.ThingLiveTest do
  use LocalizedSchemasWeb.ConnCase

  import Phoenix.LiveViewTest
  import LocalizedSchemas.ThingsFixtures

  @create_attrs %{name_en: "some name_en", name_pt: "some name_pt", name_uk: "some name_uk"}
  @update_attrs %{name_en: "some updated name_en", name_pt: "some updated name_pt", name_uk: "some updated name_uk"}
  @invalid_attrs %{name_en: nil, name_pt: nil, name_uk: nil}

  defp create_thing(_) do
    thing = thing_fixture()
    %{thing: thing}
  end

  describe "Index" do
    setup [:create_thing]

    test "lists all things", %{conn: conn, thing: thing} do
      {:ok, _index_live, html} = live(conn, ~p"/things")

      assert html =~ "Listing Things"
      assert html =~ thing.name_en
    end

    test "saves new thing", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/things")

      assert index_live |> element("a", "New Thing") |> render_click() =~
               "New Thing"

      assert_patch(index_live, ~p"/things/new")

      assert index_live
             |> form("#thing-form", thing: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#thing-form", thing: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/things")

      html = render(index_live)
      assert html =~ "Thing created successfully"
      assert html =~ "some name_en"
    end

    test "updates thing in listing", %{conn: conn, thing: thing} do
      {:ok, index_live, _html} = live(conn, ~p"/things")

      assert index_live |> element("#things-#{thing.id} a", "Edit") |> render_click() =~
               "Edit Thing"

      assert_patch(index_live, ~p"/things/#{thing}/edit")

      assert index_live
             |> form("#thing-form", thing: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#thing-form", thing: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/things")

      html = render(index_live)
      assert html =~ "Thing updated successfully"
      assert html =~ "some updated name_en"
    end

    test "deletes thing in listing", %{conn: conn, thing: thing} do
      {:ok, index_live, _html} = live(conn, ~p"/things")

      assert index_live |> element("#things-#{thing.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#things-#{thing.id}")
    end
  end

  describe "Show" do
    setup [:create_thing]

    test "displays thing", %{conn: conn, thing: thing} do
      {:ok, _show_live, html} = live(conn, ~p"/things/#{thing}")

      assert html =~ "Show Thing"
      assert html =~ thing.name_en
    end

    test "updates thing within modal", %{conn: conn, thing: thing} do
      {:ok, show_live, _html} = live(conn, ~p"/things/#{thing}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Thing"

      assert_patch(show_live, ~p"/things/#{thing}/show/edit")

      assert show_live
             |> form("#thing-form", thing: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#thing-form", thing: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/things/#{thing}")

      html = render(show_live)
      assert html =~ "Thing updated successfully"
      assert html =~ "some updated name_en"
    end
  end
end
