defmodule UrlShortenerWeb.LinkTest do
  use UrlShortener.DataCase
  alias UrlShortener.Link

  @schema_fields_and_types [
    {:id, :id},
    {:url, :string},
    {:short_url, :string},
    {:inserted_at, :utc_datetime},
    {:updated_at, :utc_datetime}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(Link, @schema_fields_and_types)
  end
end
