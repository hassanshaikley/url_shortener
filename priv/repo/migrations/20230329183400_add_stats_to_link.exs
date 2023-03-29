defmodule UrlShortener.Repo.Migrations.AddStatsToLink do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :hits, :integer, default: 0
    end
  end
end
