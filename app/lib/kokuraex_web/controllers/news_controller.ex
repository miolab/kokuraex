defmodule KokuraexWeb.NewsController do
  use KokuraexWeb, :controller

  def home(conn, _params) do
    render(
      conn,
      :home,
      layout: false
    )
  end
end
