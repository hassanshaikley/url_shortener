defmodule UrlShortenerWeb.StatsControllerTest do
  use UrlShortenerWeb.ConnCase

  test "GET /stats", %{conn: conn} do
    conn = get(conn, "/stats")

    assert html_response(conn, 200) =~ "UrlShortener"
  end
end
