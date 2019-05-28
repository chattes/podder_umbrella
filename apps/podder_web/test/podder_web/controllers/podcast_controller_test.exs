defmodule PodderWeb.PodcastControllerTest do
  use PodderWeb.ConnCase

  alias Podder.Podder
  alias Podder.Podder.Podcast

  @create_attrs %{
    podcast_name: "some podcast_name"
  }
  @update_attrs %{
    podcast_name: "some updated podcast_name"
  }
  @invalid_attrs %{podcast_name: nil}

  def fixture(:podcast) do
    {:ok, podcast} = Podder.create_podcast(@create_attrs)
    podcast
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all podcasts", %{conn: conn} do
      conn = get(conn, Routes.podcast_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create podcast" do
    test "renders podcast when data is valid", %{conn: conn} do
      conn = post(conn, Routes.podcast_path(conn, :create), podcast: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.podcast_path(conn, :show, id))

      assert %{
               "id" => id,
               "podcast_name" => "some podcast_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.podcast_path(conn, :create), podcast: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update podcast" do
    setup [:create_podcast]

    test "renders podcast when data is valid", %{conn: conn, podcast: %Podcast{id: id} = podcast} do
      conn = put(conn, Routes.podcast_path(conn, :update, podcast), podcast: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.podcast_path(conn, :show, id))

      assert %{
               "id" => id,
               "podcast_name" => "some updated podcast_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, podcast: podcast} do
      conn = put(conn, Routes.podcast_path(conn, :update, podcast), podcast: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete podcast" do
    setup [:create_podcast]

    test "deletes chosen podcast", %{conn: conn, podcast: podcast} do
      conn = delete(conn, Routes.podcast_path(conn, :delete, podcast))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.podcast_path(conn, :show, podcast))
      end
    end
  end

  defp create_podcast(_) do
    podcast = fixture(:podcast)
    {:ok, podcast: podcast}
  end
end
