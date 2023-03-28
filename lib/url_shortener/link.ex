defmodule UrlShortener.Link do
  use Ecto.Schema

  schema "links" do
    field :url, :string
    field :short_url, :string

    timestamps(type: :utc_datetime)
  end
end
