defmodule UrlShortener.Link do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :url, :string
    field :short_url, :string
    field :hits, :integer

    timestamps(type: :utc_datetime)
  end

  def changeset(link, params \\ %{}) do
    link
    |> cast(params, [:url, :hits])
    |> validate_required([:url])
    |> put_change(:short_url, generate_short_url())
    |> validate_change(:url, &verify_url/2)
    |> unique_constraint([:url, :short_url])
  end

  defp generate_short_url do
    short_code_chars = Application.get_env(:url_shortener, :short_code_chars)

    Enum.reduce(0..5, [], fn _n, acc -> acc ++ Enum.take_random(short_code_chars, 1) end)
    |> List.to_string()
  end

  defp verify_url(:url, url) do
    uri = URI.parse(url)

    case uri.scheme != nil && uri.host =~ "." do
      true -> []
      false -> [url: "Invalid url"]
    end
  end
end
