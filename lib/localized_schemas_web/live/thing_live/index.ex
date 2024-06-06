defmodule LocalizedSchemasWeb.ThingLive.Index do
  use LocalizedSchemasWeb, :live_view

  alias LocalizedSchemas.Things
  alias LocalizedSchemas.Things.Thing

  @impl true
  def mount(_params, _session, socket) do
    Gettext.get_locale(LocalizedSchemasWeb.Gettext)
    {:ok, stream(socket, :things, Things.list_things())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Thing")
    |> assign(:thing, Things.get_thing!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Thing")
    |> assign(:thing, %Thing{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Things")
    |> assign(:thing, nil)
  end

  @impl true
  def handle_info({LocalizedSchemasWeb.ThingLive.FormComponent, {:saved, thing}}, socket) do
    # TODO: convert multi-locale Thing to localized thing to avoid a crash
    {:noreply, stream_insert(socket, :things, thing)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thing = Things.get_thing!(id)
    {:ok, _} = Things.delete_thing(thing)

    {:noreply, stream_delete(socket, :things, thing)}
  end

  def locale() do
    Gettext.get_locale(LocalizedSchemasWeb.Gettext)
  end

  def fetch_localized(struct, field) do
    Map.get(struct, field <> "_" <> locale())
  end
end
