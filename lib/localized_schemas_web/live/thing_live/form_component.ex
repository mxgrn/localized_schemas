defmodule LocalizedSchemasWeb.ThingLive.FormComponent do
  use LocalizedSchemasWeb, :live_component

  alias LocalizedSchemas.Things

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>This form uses a schema that includes <em>all</em> localization fields</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="thing-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name_en]} type="text" label="Name en" />
        <.input field={@form[:name_pt]} type="text" label="Name pt" />
        <.input field={@form[:name_uk]} type="text" label="Name uk" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Thing</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{thing: thing} = assigns, socket) do
    changeset = Things.change_thing(thing)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"thing" => thing_params}, socket) do
    changeset =
      socket.assigns.thing
      |> Things.change_thing(thing_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"thing" => thing_params}, socket) do
    save_thing(socket, socket.assigns.action, thing_params)
  end

  defp save_thing(socket, :edit, thing_params) do
    case Things.update_thing(socket.assigns.thing, thing_params) do
      {:ok, thing} ->
        notify_parent({:saved, thing})

        {:noreply,
         socket
         |> put_flash(:info, "Thing updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_thing(socket, :new, thing_params) do
    case Things.create_thing(thing_params) do
      {:ok, thing} ->
        notify_parent({:saved, thing})

        {:noreply,
         socket
         |> put_flash(:info, "Thing created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
