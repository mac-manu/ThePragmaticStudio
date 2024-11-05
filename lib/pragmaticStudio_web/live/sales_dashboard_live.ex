defmodule PragmaticStudioWeb.SalesDashboardLive do
  use PragmaticStudioWeb, :live_view

  alias PragmaticStudio.Sales
  #mount
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = assign_stats(socket)

    {:ok, socket}
  end
  #render
  def render(assigns) do
    ~H"""
    <h1>Sales Dashboard</h1>

    <div class="mx-auto max-w-7xl px-6 lg:px-8">
        <dl class="grid grid-cols-1 gap-x-8 gap-y-16 text-center lg:grid-cols-3">
          <div class="mx-auto flex max-w-xs flex-col gap-y-4">
            <dt class="text-base/7 text-gray-600">New Orders</dt>
            <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900 sm:text-5xl"><%= @new_orders %></dd>
          </div>
          <div class="mx-auto flex max-w-xs flex-col gap-y-4">
            <dt class="text-base/7 text-gray-600">Sales Amount</dt>
            <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900 sm:text-5xl"> $<%= @sales_amount %></dd>
          </div>
          <div class="mx-auto flex max-w-xs flex-col gap-y-4">
            <dt class="text-base/7 text-gray-600">Satisfaction</dt>
            <dd class="order-first text-3xl font-semibold tracking-tight text-gray-900 sm:text-5xl"><%= @satisfaction %>%</dd>
          </div>
        </dl>
      </div>



      <button phx-click="refresh" class="btn btn">

        Refresh
      </button>

    """
  end


  #event handler
  def handle_event("refresh", _, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end


end
