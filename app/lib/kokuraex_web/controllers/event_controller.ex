defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  alias Kokuraex.Services.EventFunction

  def home(conn, _params) do
    render(
      conn,
      :home,
      layout: false,
      kokura_events: EventFunction.kokuraex_connpass_events(),
      pelemay_events: EventFunction.pelemay_connpass_events()
    )
  end
end
