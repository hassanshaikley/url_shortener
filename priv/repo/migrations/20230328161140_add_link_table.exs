defmodule UrlShortener.Repo.Migrations.AddLinkTable do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :short_url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
