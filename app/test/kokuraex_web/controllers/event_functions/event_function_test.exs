defmodule KokuraexWeb.EventFunctionTest do
  use KokuraexWeb.ConnCase
  import KokuraexWeb.EventFunction

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

  test "test_kokura.exのconnpassイベントが取得できる（該当イベント数が1件のケース）" do
    [hd | _] = connpass_events("kokura_ex", "1")

    result =
      Map.get(hd, :title)
      |> String.contains?("kokura.ex")

    assert result === true
  end

  test "test_kokura.exのconnpassイベントが取得できる（該当イベント数が2件以上のケース）" do
    [hd | _] = connpass_events("kokura_ex", "3")

    result =
      Map.get(hd, :title)
      |> String.contains?("kokura.ex")

    assert result === true
  end

  test "test_該当イベントが存在しなかった場合は`No events found`タイトルを表示する" do
    [hd | _] =
      connpass_events(
        "hard_to_exist_event_keyword_foo_bar_foo_bar",
        "3"
      )

    expected = %{
      address: "-",
      catch: "-",
      ended_at: "-",
      event_url: "https://kokura-ex.herokuapp.com/",
      started_at: "-",
      title: "No events found"
    }

    assert hd === expected
  end

  test "test_pelemayのconnpassイベント数が意図した数値で取得できる" do
    actual =
      pelemay_connpass_events()
      |> Enum.count()

    assert actual == 5
  end
end
