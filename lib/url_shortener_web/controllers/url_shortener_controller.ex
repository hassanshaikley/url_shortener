defmodule UrlShortenerWeb.UrlShortenerController do
  use UrlShortenerWeb, :controller

  def shorten(conn, _params) do
    short_url = "/short_url"
    json(conn, %{short_url: short_url})
  end
end
