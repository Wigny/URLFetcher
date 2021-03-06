defmodule URLFetcher.URLs do
  @moduledoc """
  The URLs context.
  """

  @type fetched_url :: %{
          base: String.t(),
          links: list(String.t()),
          assets: list(String.t())
        }

  @spec fetch_url(String.t()) :: {:ok, fetched_url} | {:error, any}
  def fetch_url(url) do
    with {:ok, response} <- Tesla.get(url),
         {:ok, document} <- Floki.parse_document(response.body) do
      links =
        document
        |> Floki.find("a")
        |> Floki.attribute("href")
        |> Enum.reject(&(not valid_url?(&1)))
        |> Enum.uniq()
        |> Enum.map(&build_absolute_url(&1, response.url))

      assets =
        document
        |> Floki.find("img")
        |> Floki.attribute("src")
        |> Enum.uniq()
        |> Enum.map(&build_absolute_url(&1, response.url))

      {:ok, %{base: response.url, links: links, assets: assets}}
    else
      {:error, error} -> {:error, error}
    end
  end

  defp valid_url?(url) do
    uri = URI.parse(url)
    uri.scheme != nil && uri.host != nil && uri.host =~ "."
  end

  defp build_absolute_url(url, base) do
    base
    |> URI.merge(url)
    |> to_string()
  end
end
