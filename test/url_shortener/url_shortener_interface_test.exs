defmodule UrlShortener.UrlShortenerInterfaceTest do
  use UrlShortener.DataCase
  import ExUnit.CaptureLog

  alias UrlShortener.Link
  alias UrlShortener.UrlShortenerInterface

  describe "create_or_fetch_link_by_url/1" do
    test "generates a short url if it doesnt exist" do
      capture_log(fn ->
        url = "https://google.com"
        UrlShortenerInterface.create_or_fetch_link_by_url(url)
      end) =~ "Doesn't exist, creating link"
    end

    test "does not generates a short_url if alreaady exists" do
      url = "https://some_url2.com"
      link = %Link{url: url}
      changeset = Link.changeset(link)
      UrlShortener.Repo.insert!(changeset)

      capture_log(fn ->
        UrlShortenerInterface.create_or_fetch_link_by_url(url)
      end) =~ "Already exists, fetching link"
    end
  end

  describe "get_link_by_short_url/1" do
    test "returns a link when exists and increments hits" do
      url = "https://some_url3.com"
      link = %Link{url: url}

      changeset = Link.changeset(link)
      inserted_link = UrlShortener.Repo.insert!(changeset)

      link = UrlShortenerInterface.get_link_by_short_url(inserted_link.short_url)
      assert link.hits == 1
    end
  end
end
