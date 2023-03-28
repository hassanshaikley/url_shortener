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

  describe "changeset/1" do
    test "valid when url is valid url and sort url is valid url" do
      link = %Link{url: "http://some_url.com/"}
      changeset = Link.changeset(link)
      short_url = changeset.changes.short_url
      assert String.length(short_url) === 6
      assert changeset.valid?
    end

    test "invalid when url is invalid" do
      link = %Link{url: "invalid_url"}
      changeset = Link.changeset(link)
      refute changeset.valid?
    end
  end
end
