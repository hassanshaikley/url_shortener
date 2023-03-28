defmodule UrlShortenerWeb.UrlShortenerController do
  use UrlShortenerWeb, :controller

  require Logger

  alias UrlShortener.Link

  def create(conn, params) do
    url = params["url"]

    link =
      case UrlShortener.Repo.get_by(Link, url: url) do
        nil ->
          Logger.notice("Doesn't exist, creating link")

          changeset = Link.changeset(%Link{}, %{url: url})
          UrlShortener.Repo.insert(changeset)

        link ->
          Logger.notice("Already exists, fetching link")

          {:ok, link}
      end

    case link do
      {:error, _changeset} ->
        json(conn, %{error: "Invalid url"})

      {:ok, link} ->
        json(conn, %{short_url: link.short_url})
    end
  end

  def show(conn, params) do
    short_url = params["short_url"]

    case UrlShortener.Repo.get_by(Link, short_url: short_url) do
      nil ->
        conn
        |> put_flash(:error, "Invalid short code, try regenerating")
        |> redirect(to: "/")

      link ->
        redirect(conn, external: link.url)
    end
  end
end
