defmodule URLFetcherWeb.URLView do
  use URLFetcherWeb, :view
  alias URLFetcherWeb.URLView

  def render("show.json", %{url: url}) do
    %{data: render_one(url, URLView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{base: url.base, assets: url.assets, links: url.links}
  end
end
