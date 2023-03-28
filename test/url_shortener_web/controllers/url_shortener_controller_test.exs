defmodule UrlShortenerWeb.UrlShortenerControllerTest do
  use UrlShortenerWeb.ConnCase

  test "GET /api/shorten", %{conn: conn} do
    conn = post(conn, "/api/shorten")
    assert json_response(conn, 200) == %{"short_url" => "/short_url"}
  end
end
