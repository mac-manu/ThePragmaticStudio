defmodule PragmaticStudioWeb.LightLive do
  use PragmaticStudioWeb, :live_view


  # mount
  def mount(_params, _session, socket ) do
    socket = assign(socket, brightness: 10)
    #IO.inspect(socket)
    {:ok, socket}
  end
  # render
  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
      <span style={"width: #{@brightness} %"}>
      <%= @brightness %>%
      </span>
      </div>

      <button phx-click="off">
        <img src="/images/light-off.svg" width="50" height="50">
      </button>

      <button phx-click="down">
        <img src="/images/down.svg" width="50" height="50">
      </button>

      <button phx-click="rando">
        <img src="/images/rando.svg" width="50" height="50">
      </button>

      <button phx-click="up">
        <img src="/images/up.svg" width="50" height="50">
      </button>

      <button phx-click="on">
        <img src="/images/light-on.svg" width="50" height="50">
      </button>

    </div>
    """
  end

  # handle_event

  def handle_event("on", _unsigned_params, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("off", _unsigned_params, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end

  def handle_event("up", _unsigned_params, socket) do
    #brightness = socket.assings.brightness + 10
    socket = update(socket, :brightness,&min(&1+10, 100))

    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    socket = update(socket, :brightness,&max(&1-10, 0))
    {:noreply, socket}
  end

  def handle_event("rando", _, socket) do
    socket = assign(socket, :brightness, Enum.random(0..100))
    {:noreply, socket}
  end

end
