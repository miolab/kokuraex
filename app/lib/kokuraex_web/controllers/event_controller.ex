defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  def index(conn, _params) do
    url = "https://connpass.com/api/v1/event/?keyword=kokura_ex"
    res = HTTPoison.get!(url)

    render(
      conn,
      "index.html",
      text: "[WIP] #{res.request_url}"
    )
  end
end
