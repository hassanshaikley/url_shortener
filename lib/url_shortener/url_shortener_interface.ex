defmodule UrlShortener.UrlShortenerInterface do
  @moduledoc """
  Business logic around creating/fetching a link by the link
  As well as fetching a link by the short url
  """
  require Logger

  alias UrlShortener.Link

  def create_or_fetch_link_by_url(url) do
    case UrlShortener.Repo.get_by(Link, url: url) do
      nil ->
        Logger.notice("Doesn't exist, creating link")

        changeset = Link.changeset(%Link{}, %{url: url, hits: 0})
        UrlShortener.Repo.insert(changeset)

      link ->
        Logger.notice("Already exists, fetching link")

        {:ok, link}
    end
  end

  def get_link_by_short_url(short_url) do
    case UrlShortener.Repo.get_by(Link, short_url: short_url) do
      nil ->
        nil

      link ->
        updated_link = Ecto.Changeset.change(link, hits: link.hits + 1)
        UrlShortener.Repo.update!(updated_link)
    end
  end
end
