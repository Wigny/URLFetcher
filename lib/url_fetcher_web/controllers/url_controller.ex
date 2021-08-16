defmodule URLFetcherWeb.URLController do
  use URLFetcherWeb, :controller

  alias URLFetcher.URLs
  alias URLFetcher.URLs.URL

  action_fallback URLFetcherWeb.FallbackController

  def index(conn, _params) do
    urls = URLs.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %URL{} = url} <- URLs.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = URLs.get_url!(id)
    render(conn, "show.json", url: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = URLs.get_url!(id)

    with {:ok, %URL{} = url} <- URLs.update_url(url, url_params) do
      render(conn, "show.json", url: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = URLs.get_url!(id)

    with {:ok, %URL{}} <- URLs.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end
end
