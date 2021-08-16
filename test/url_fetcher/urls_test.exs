defmodule URLFetcher.URLSTest do
  use URLFetcher.DataCase

  alias URLFetcher.URLs

  describe "urls" do
    alias URLFetcher.URLs.URL

    @valid_attrs %{assets: [], links: []}
    @update_attrs %{assets: [], links: []}
    @invalid_attrs %{assets: nil, links: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> URLs.create_url()

      url
    end

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert URLs.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert URLs.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %URL{} = url} = URLs.create_url(@valid_attrs)
      assert url.assets == []
      assert url.links == []
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = URLs.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %URL{} = url} = URLs.update_url(url, @update_attrs)
      assert url.assets == []
      assert url.links == []
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = URLs.update_url(url, @invalid_attrs)
      assert url == URLs.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %URL{}} = URLs.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> URLs.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = URLs.change_url(url)
    end
  end
end
