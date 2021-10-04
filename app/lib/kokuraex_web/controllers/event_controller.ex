defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
