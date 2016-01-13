defmodule ElixirChina.NotificationController do
  use ElixirChina.Web, :controller

  import ElixirChina.ControllerUtils
  alias ElixirChina.Notification

  def index(conn, _params) do
    current_user_id = get_user_id(conn)
    query = from n in Notification, where: n.user_id == ^current_user_id, preload: :post
    render conn, "index.html", notifications: Repo.all(query),
                          user_id: get_session(conn, :user_id),
                          current_user: Repo.one(from u in User, where: u.id == ^get_session(conn, :user_id))
  end

  def delete(conn, %{"id" => id}) do
    current_user_id = get_user_id(conn)
    query = from n in Notification, where: n.id == ^String.to_integer(id) and n.user_id == ^current_user_id, preload: :post
    notification = hd(Repo.all(query))
    Repo.delete(notification)
    text conn, "success"
  end
end
