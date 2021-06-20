defmodule KokuraExWeb.PageControllerTest do
  use KokuraExWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "GET /about", %{conn: conn} do
    conn = get(conn, "/about")
    assert html_response(conn, 200) =~ "About"
  end
end
