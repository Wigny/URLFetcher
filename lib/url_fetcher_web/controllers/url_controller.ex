defmodule URLFetcherWeb.URLController do
  use URLFetcherWeb, :controller

  alias URLFetcher.URLs
  alias URLFetcher.URLs.URL

  action_fallback URLFetcherWeb.FallbackController

  def show(conn, %{"url" => url}) do
    with {:ok, fetched_url} = URLs.fetch_url(url) do
      render(conn, "show.json", url: fetched_url)
    end
  end
end
