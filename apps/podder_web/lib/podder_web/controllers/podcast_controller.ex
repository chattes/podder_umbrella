defmodule PodderWeb.PodcastController do
  use PodderWeb, :controller

  alias Podder.DynamicSupervisor, as: PodderSup

  action_fallback PodderWeb.FallbackController

  def index(conn, _params) do
    podcasts = Podder.list_podcasts()
    render(conn, "index.json", podcasts: podcasts)
  end

  def create(conn, %{"podcast" => podcast_params}) do
    with {:ok, pid} <- Podder.DynamicSupervisor.start_work(podcast_params) do
      conn =
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, 200))

      json(conn, %{"data" => "Server Started"})
    else
      {:error, {:already_started, pid}} -> json(conn, %{"data" => "Already Running"})
      _ -> json(conn, %{"data" => "Error Creating Podcast"})
    end
  end

  # def show(conn, %{"id" => id}) do
  #   podcast = Podder.get_podcast!(id)
  #   render(conn, "show.json", podcast: podcast)
  # end
  #
  # def update(conn, %{"id" => id, "podcast" => podcast_params}) do
  #   podcast = Podder.get_podcast!(id)
  #
  #   with {:ok, %Podcast{} = podcast} <- Podder.update_podcast(podcast, podcast_params) do
  #     render(conn, "show.json", podcast: podcast)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   podcast = Podder.get_podcast!(id)
  #
  #   with {:ok, %Podcast{}} <- Podder.delete_podcast(podcast) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
