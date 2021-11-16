defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller
  import KokuraexWeb.EventFunction

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      kokura_events: kokuraex_connpass_events(),
      pelemay_events: pelemay_connpass_events()
    )
  end
end
