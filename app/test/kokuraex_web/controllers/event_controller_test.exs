defmodule KokuraexWeb.EventControllerTest do
  use KokuraexWeb.ConnCase

  test "GET /event", %{conn: conn} do
    conn = get(conn, ~p"/event")
    assert html_response(conn, 200) =~ "Event"
  end
end
