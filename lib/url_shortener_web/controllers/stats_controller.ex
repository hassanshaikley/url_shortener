defmodule UrlShortenerWeb.StatsController do
  use UrlShortenerWeb, :controller

  def index(conn, _params) do
    links = UrlShortener.Repo.all(UrlShortener.Link)

    render(conn, "index.html", links: links)
  end
end
