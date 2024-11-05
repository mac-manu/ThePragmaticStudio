defmodule PragmaticStudioWeb.SearchLive do
  use PragmaticStudioWeb, :live_view

  alias PragmaticStudio.Stores
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
      zip: "",
      stores: [])   #Stores.list_stores())
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find a Store</h1>
    <div id="search">

      <form phx-submit="zip-search">
      <!--    phx-change busca cada vez -->
        <input type="text" name="zip" value="<%= @zip %>"
        placeholder="zip code"
        autofocus autocomplete="off" />
        <button>
          <img src="images/search.svg" >
        </button>
      </form>

      <div class="stores">
        <ul>
          <%= for store <- @stores do %>
            <li>
              <div class="first-line">
                <div class="name">
                  <%= store.name %>
                </div>
                <div class="status">
                  <%= if store.open do %>
                    <span class="open">Open</span>
                  <% else %>
                    <span class="closed">Closed</span>
                  <% end %>
                </div>
              </div>
              <div class="second-line">
                <div class="street">
                  <img src="images/location.svg" width="20">
                  <%= store.street %>
                </div>
                <div class="phone_number">
                  <img src="images/phone.svg" width="20" >
                  <%= store.phone_number %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("zip-search", %{"zip" => zip}, socket) do
    socket =
      assign(socket,
      zip: zip,
      stores: Stores.search_by_zip(zip)
      )
    {:noreply, socket}
  end

end
