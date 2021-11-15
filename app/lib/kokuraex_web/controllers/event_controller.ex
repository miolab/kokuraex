defmodule KokuraexWeb.EventController do
  use KokuraexWeb, :controller

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      kokura_events:
        connpass_events(
          "kokura_ex",
          "5"
        ),
      pelemay_events:
        connpass_events(
          "Pelemay Meetup SIMD勉強会",
          "3"
        )
    )
  end

  # TODO: EventControllerから別ファイルへメソッドを切り出す

  def get_connpass_events(keyword, count) do
    "https://connpass.com/api/v1/event/?keyword=#{keyword}&order=2&count=#{count}"
    |> HTTPoison.get()
  end

  def handle_httpoison_result(res) do
    case res do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
      {:ok, %HTTPoison.Response{status_code: 404}} -> :httpoison_notfound
      {:error, %HTTPoison.Error{reason: _}} -> :httpoison_error
      _ -> :httpoison_unknown
    end
  end

  def connpass_events(keyword, count) do
    res =
      get_connpass_events(keyword, count)
      |> handle_httpoison_result()

    case res do
      :httpoison_notfound ->
        default_events_map()

      :httpoison_error ->
        %{default_events_map() | title: "Fetch Error"}

      :httpoison_unknown ->
        %{default_events_map() | title: "Unknown Error"}

      _ ->
        res_decoded = Jason.decode!(res)

        cond do
          Map.has_key?(res_decoded, "events") ->
            res_decoded["events"]
            |> Enum.map(
              &%{
                default_events_map()
                | title: &1["title"],
                  started_at: &1["started_at"],
                  ended_at: &1["ended_at"],
                  catch: &1["catch"],
                  address: &1["address"],
                  event_url: &1["event_url"]
              }
            )

          true ->
            %{default_events_map() | title: "Events Empty"}
        end
    end
  end

  def default_events_map() do
    %{
      title: "Not Found",
      started_at: "-",
      ended_at: "-",
      catch: "-",
      address: "-",
      event_url: "https://kokura-ex.herokuapp.com/"
    }
  end
end
