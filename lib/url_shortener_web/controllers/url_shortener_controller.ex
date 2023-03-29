defmodule UrlShortenerWeb.UrlShortenerController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.UrlShortenerInterface

  def create(conn, params) do
    url = params["url"]

    link = UrlShortenerInterface.create_or_fetch_link_by_url(url)

    case link do
      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> json(%{error: "Invalid url"})

      {:ok, link} ->
        json(conn, %{short_url: link.short_url})
    end
  end

  def show(conn, params) do
    short_url = params["short_url"]

    case UrlShortenerInterface.get_link_by_short_url(short_url) do
      nil ->
        conn
        |> put_flash(:error, "Invalid short code, try regenerating")
        |> redirect(to: "/")

      link ->
        redirect(conn, external: link.url)
    end
  end
end
