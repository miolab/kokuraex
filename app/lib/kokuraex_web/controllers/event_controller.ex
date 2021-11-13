defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      kokura_events: connpass_events("kokura_ex", "5"),
      pelemay_events: connpass_events("Pelemay Meetup SIMD勉強会", "3")
    )
  end

  def get_connpass_events(keyword, count) do
    "https://connpass.com/api/v1/event/?keyword=#{keyword}&order=2&count=#{count}"
    |> HTTPoison.get!()
  end

  def connpass_events(keyword, count) do
    # TODO: エラーハンドリング
    # - get_connpass_events(keyword, count)が、:error の場合
    # - カラの場合
    # - 正常系
    # Map.has_key?()

    res =
      get_connpass_events(keyword, count)
      |> Map.get(:body)
      |> Jason.decode!()

    events = res["events"]

    # TODO: エラー時にカラを返すか、テスト書く（もしくは両方）
    # Map.has_key?()

    events
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
