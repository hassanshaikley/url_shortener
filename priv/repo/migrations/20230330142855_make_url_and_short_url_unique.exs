defmodule UrlShortener.Repo.Migrations.MakeUrlAndShortUrlUnique do
  use Ecto.Migration

  def change do
    create unique_index(:links, [:short_url])
    create unique_index(:links, [:url])
  end
end
