defmodule KokuraexWeb.PageControllerTest do
  use KokuraexWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "kokura.exは開発言語Elixirをわいわい盛り上げていく技術コミュニティです"
  end

  test "GET /about", %{conn: conn} do
    conn = get(conn, "/about")
    assert html_response(conn, 200) =~ "About"
  end

  test "GET /event", %{conn: conn} do
    conn = get(conn, "/event")
    assert html_response(conn, 200) =~ "Event"
  end

  # TODO: EventController用のテストを各メソッドごとに切り出す
  # NITS: testメッセージ英語化
  import KokuraexWeb.EventController

  test "test_HTTPoisonでconnpass APIに対してkeyword=kokura_exで叩いてGETできる" do
    result =
      get_connpass_events("kokura_ex", "2")
      |> elem(0)

    assert result === :ok
  end

  test "test_`handle_httpoison_result/1`の実行結果が404だったら`:httpoison_notfound`を返す" do
    result =
      {:ok, %HTTPoison.Response{status_code: 404}}
      |> handle_httpoison_result()

    assert result === :httpoison_notfound
  end

  test "test_`handle_httpoison_result/1`の実行結果がレスポンスエラーだったら`:httpoison_error`を返す" do
    result =
      {:error, %HTTPoison.Error{reason: "Some reason of error"}}
      |> handle_httpoison_result()

    assert result === :httpoison_error
  end

  test "test_異常系_`handle_httpoison_result/1`でエラーキャッチできなかったら`:httpoison_unknown`を返す" do
    result =
      "Unknown result"
      |> handle_httpoison_result()

    assert result === :httpoison_unknown
  end

  @default_events_map %{
    address: "-",
    catch: "-",
    ended_at: "-",
    event_url: "https://kokura-ex.herokuapp.com/",
    started_at: "-",
    title: "Not Found"
  }

  test "デフォルトのEvent表示用マップが正しく取得できる" do
    assert default_events_map() === @default_events_map
  end

  test "test_kokura.exのconnpassイベントが取得できる" do
    [h | _] = connpass_events("kokura_ex", "2")

    result =
      Map.get(h, :title)
      |> String.contains?("kokura.ex")

    assert result === true
  end
end
