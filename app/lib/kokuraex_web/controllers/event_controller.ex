defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  def index(conn, _params) do
    events_arr = connpass_events()

    render(
      conn,
      "index.html",
      events: events_arr
    )
  end

  def connpass_events() do
    connpass_url = "https://connpass.com/api/v1/event/?keyword=kokura_ex&order=2&count=5"

    res =
      HTTPoison.get!(connpass_url)
      |> Map.get(:body)
      |> Jason.decode!()

    # TODO: エラーハンドリング
    # - 200じゃない場合
    # - カラの場合
    # - 正常系
    # Map.has_key?()

    # TODO: イメージキャプチャも（もしあれば）
    res["events"]
    |> Enum.map(
      &%{
        :title => &1["title"],
        :started_at => &1["started_at"],
        :ended_at => &1["ended_at"],
        :catch => &1["catch"],
        :address => &1["address"],
        :event_url => &1["event_url"]
      }
    )
  end
end
