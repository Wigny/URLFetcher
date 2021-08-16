defmodule URLFetcher.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :assets, {:array, :string}
      add :links, {:array, :string}

      timestamps()
    end

  end
end
