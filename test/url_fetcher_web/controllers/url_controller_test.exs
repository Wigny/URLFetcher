defmodule URLFetcherWeb.URLControllerTest do
  use URLFetcherWeb.ConnCase

  import Tesla.Mock

  alias URLFetcher.URLs

  setup %{conn: conn} do
    mock(fn
      %{url: "https://placeholder.com"} ->
        %Tesla.Env{
          url: "https://placeholder.com",
          status: 200,
          body: """
          <html>

          <head>
            <title>Mock Page</title>
          </head>

          <body>
            <a href="https://placeholder.com">
              <img src="https://via.placeholder.com/150">
            </a>
          </body>

          </html>
          """
        }

      %{url: "http://test.test"} ->
        {:error, :econnrefused}
    end)

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create url" do
    test "fetchs url when url is valid", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :show), url: "https://placeholder.com")

      assert %{
               "base" => "https://placeholder.com",
               "assets" => ["https://via.placeholder.com/150"],
               "links" => ["https://placeholder.com"]
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when url is invalid", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :show), url: "http://test.test")

      assert %{"detail" => "econnrefused"} = json_response(conn, 422)["errors"]
    end
  end
end
