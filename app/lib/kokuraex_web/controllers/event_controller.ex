defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  # import KokuraexWeb.EventFunction

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(
      conn,
      :home,
      layout: false
      # kokura_events: kokuraex_connpass_events(),
      # pelemay_events: pelemay_connpass_events()
    )
  end
end
