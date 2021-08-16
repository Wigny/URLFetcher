defmodule URLFetcher.URLs.URL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field(:assets, {:array, :string})
    field(:links, {:array, :string})

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:assets, :links])
    |> validate_required([:assets, :links])
  end
end
