defmodule UrlShortener.Repo.Migrations.AddLinkTable do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :short_url, :string

      timestamps(type: :utc_datetime)
    end

    unique_index(:links, :url)
    unique_index(:short_url, :url)
  end
end
