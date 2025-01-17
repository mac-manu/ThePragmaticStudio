defmodule PragmaticStudioWeb.LicenseLive do
  use PragmaticStudioWeb, :live_view
  #import Number.Currency
  alias PragmaticStudio.Licenses
  # mount
  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 2 , amount: Licenses.calculate(2) )
    {:ok, socket }
  end
  # render
  def render(assigns) do
    ~H"""
    <h1>TEAM License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg">
            <span>
            Your license is currently for
            <strong><%= @seats %></strong> seats.
            </span>
          </div>

          <form phx-change="update">
            <input type="range" min="1" max="10" name="seats" value="{@seats}"/>
          </form>

          <div class="amount">
            <%=  (@amount) %>
          </div>
        </div>
      </div>
    </div>
    """
  end
  #event handler
  def handle_event("update", %{"seats" => seats }, socket) do
    seats = String.to_integer(seats)
    socket = assign(socket , seats: seats, amount: Licenses.calculate(seats) )
    {:noreply, socket}
  end
end
