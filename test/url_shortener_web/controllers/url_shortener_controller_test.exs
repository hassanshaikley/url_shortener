defmodule UrlShortenerWeb.UrlShortenerControllerTest do
  use UrlShortenerWeb.ConnCase
  import ExUnit.CaptureLog

  alias UrlShortener.Link

  describe "GET /api/create" do
    test "generates a short_url given a url", %{conn: conn} do
      url = "https://some_url.com"

      capture_log(fn ->
        conn = post(conn, "/api/create", %{"url" => url})
        response = json_response(conn, 200)
        assert %{"short_url" => short_url} = response
        assert String.length(short_url) == 6
      end) =~ "Doesn't exist, creating link"
    end

    test "does not generates a short_url if alreaady exists", %{conn: conn} do
      url = "https://some_url2.com"
      link = %Link{url: url}
      changeset = Link.changeset(link)
      UrlShortener.Repo.insert!(changeset)

      capture_log(fn ->
        conn = post(conn, "/api/create", %{"url" => url})
        response = json_response(conn, 200)
        assert %{"short_url" => short_url} = response
        assert String.length(short_url) == 6
      end) =~ "Already exists, fetching link"
    end

    test "returns an error when url is invalid", %{conn: conn} do
      url = "invalid_url"

      capture_log(fn ->
        conn = post(conn, "/api/create", %{"url" => url})
        response = json_response(conn, 400)
        assert %{"error" => "Invalid url"} = response
      end)
    end
  end

  describe "GET /{id}" do
    test "redirects to url when valid and increments hits", %{conn: conn} do
      url = "https://some_url2.com"
      link = %Link{url: url}

      changeset = Link.changeset(link)
      inserted_link = UrlShortener.Repo.insert!(changeset)

      conn = get(conn, "/#{inserted_link.short_url}")

      assert redirected_to(conn) == url

      updated_link_post_hit = UrlShortener.Repo.get(Link, inserted_link.id)
      assert updated_link_post_hit.hits == 1
    end

    test "flashes with an error when invalid", %{conn: conn} do
      conn = get(conn, "/123456")
      assert get_flash(conn, :error) =~ "Invalid short code, try regenerating"
    end
  end
end
