defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  # alias Kokuraex.Services.EventFunction

  def home(conn, _params) do
    render(
      conn,
      :home,
      layout: false
    )
  end
end
