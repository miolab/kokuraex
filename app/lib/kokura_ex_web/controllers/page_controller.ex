defmodule KokuraExWeb.PageController do
  use KokuraExWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
