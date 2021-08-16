defmodule URLFetcher.URLSTest do
  use ExUnit.Case

  import Tesla.Mock

  alias URLFetcher.URLs

  setup do
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

      %{url: "https://jsonplaceholder.typicode.com/todos/1"} ->
        json(%{userId: 1, id: 1, title: "delectus aut autem", completed: false})

      %{url: "http://test.test"} ->
        {:error, :econnrefused}
    end)

    :ok
  end

  describe "urls" do
    test "fetch_url/1 with a valid page URL fetch URLs" do
      assert {:ok, url} = URLs.fetch_url("https://placeholder.com")
      assert url.assets == ["https://via.placeholder.com/150"]
      assert url.links == ["https://placeholder.com"]
    end

    test "fetch_url/1 with a valid non-page URL returns empty results" do
      assert {:ok, url} = URLs.fetch_url("https://jsonplaceholder.typicode.com/todos/1")
      assert url.assets == []
      assert url.links == []
    end

    test "fetch_url/1 with unknown domain returns an error" do
      assert {:error, :econnrefused} = URLs.fetch_url("http://test.test")
    end
  end
end
