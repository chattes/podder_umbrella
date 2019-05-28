defmodule PodderWeb.PodcastView do
  use PodderWeb, :view
  alias PodderWeb.PodcastView

  def render("index.json", %{podcasts: podcasts}) do
    %{data: render_many(podcasts, PodcastView, "podcast.json")}
  end

  def render("show.json", %{podcast: podcast}) do
    %{data: render_one(podcast, PodcastView, "podcast.json")}
  end

  def render("podcast.json", %{podcast: podcast}) do
    %{id: podcast.id,
      podcast_name: podcast.podcast_name}
  end
end
