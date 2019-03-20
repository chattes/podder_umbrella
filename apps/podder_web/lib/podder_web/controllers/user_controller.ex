defmodule PodderWeb.UserController do
  use PodderWeb, :controller

  alias Podder.DynamicSupervisor, as: PodderSup

  action_fallback PodderWeb.FallbackController

  def index(conn, _params) do
    users = []
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, pid} <- PodderSup.log_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user_params))
      |> render("show.json", user: user_params)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   user = Podder.get_user!(id)
  #   render(conn, "show.json", user: user)
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Podder.get_user!(id)

  #   with {:ok, %User{} = user} <- Podder.update_user(user, user_params) do
  #     render(conn, "show.json", user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = Podder.get_user!(id)

  #   with {:ok, %User{}} <- Podder.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
