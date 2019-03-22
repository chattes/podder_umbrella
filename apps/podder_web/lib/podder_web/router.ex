defmodule PodderWeb.Router do
  use PodderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PodderWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    get "/podcasts/:query", UserController, :show
  end
end
