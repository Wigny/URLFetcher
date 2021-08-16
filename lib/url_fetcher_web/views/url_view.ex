defmodule URLFetcherWeb.URLView do
  use URLFetcherWeb, :view
  alias URLFetcherWeb.URLView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, URLView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, URLView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{id: url.id,
      assets: url.assets,
      links: url.links}
  end
end
