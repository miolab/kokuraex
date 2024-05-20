defmodule KokuraexWeb.AboutControllerTest do
  use KokuraexWeb.ConnCase

  test "GET /about", %{conn: conn} do
    conn = get(conn, ~p"/about")
    assert html_response(conn, 200) =~ "About"
  end
end
