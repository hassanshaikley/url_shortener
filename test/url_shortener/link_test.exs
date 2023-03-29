defmodule UrlShortener.LinkTest do
  use UrlShortener.DataCase
  alias UrlShortener.Link

  @schema_fields_and_types [
    {:id, :id},
    {:url, :string},
    {:short_url, :string},
    {:inserted_at, :utc_datetime},
    {:updated_at, :utc_datetime},
    {:hits, :integer}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(Link, @schema_fields_and_types)
  end

  describe "changeset/1" do
    test "valid when url is valid url and sort url is valid url" do
      url = "http://some_url.com/"
      changeset = Link.changeset(%Link{}, %{url: url})
      short_url = changeset.changes.short_url
      assert String.length(short_url) === 6
      assert changeset.changes.url === url
      assert changeset.valid?
    end

    test "invalid when url is invalid" do
      url = "invalid_url"
      changeset = Link.changeset(%Link{}, %{url: url})
      refute changeset.valid?
    end

    test "able to update hits" do
      url = "http://some_url.com/"
      changeset = Link.changeset(%Link{url: url}, %{hits: 1})
      assert changeset.valid?
      assert changeset.changes.hits === 1
    end
  end
end
