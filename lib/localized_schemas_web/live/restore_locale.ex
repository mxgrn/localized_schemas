defmodule LocalizedSchemasWeb.RestoreLocale do
  @doc """
  Pick up locale from session in LiveView (accessible via locale/0 helper method).
  """
  def on_mount(:default, _params, %{"locale" => locale}, socket) do
    Gettext.put_locale(LocalizedSchemasWeb.Gettext, locale)
    {:cont, socket}
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, socket}
  end
end
