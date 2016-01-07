defmodule ElixirChina.UserController do
  use ElixirChina.Web, :controller

  import ElixirChina.ControllerUtils
  alias ElixirChina.User

  def index(conn, _params) do
    redirect conn, "/"
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def new(conn, _params) do
    render conn, "new.html", user_id: nil, errors: nil
  end

  def create(conn, %{"user" => %{"email" => email, "name" => name, "password" => password}}) do
    user = %{email: email, name: name, admin: false, password: password}
    # validate_result = User.validate(user)

    changeset = User.changeset(%User{}, user)

    bad_name_list = [
      "root", "admin", "administrator", "post", "bot", "robot", "master", "webmaster",
      "account", "people", "user", "users", "project", "projects",
      "search", "action", "favorite", "like", "love", "none", "nil",
      "team", "teams", "group", "groups", "organization",
      "organizations", "package", "packages", "org", "com", "net",
      "help", "doc", "docs", "document", "documentation", "blog",
      "bbs", "forum", "forums", "static", "assets", "repository",
      "public", "private"
    ]

    if name in bad_name_list do
      changeset = Ecto.Changeset.add_error(changeset, :name, "无效的用户名")
    end

    if changeset.valid? do
      changeset = Ecto.Changeset.put_change(changeset, :password, user.password |> User.encrypt_password |> to_string)
      case Repo.insert(changeset) do
        {:ok, user} ->
          conn = put_session conn, :user_id, user.id
          conn = put_session conn, :current_user, user
          render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
        {:error, changeset} ->
          render conn, "new.html", user: user, errors: changeset.errors, user_id: get_session(conn, :user_id)
      end
    else
      render conn, "new.html", user: user, errors: changeset.errors, user_id: get_session(conn, :user_id)
    end
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_user_id(conn)
    if user_id != String.to_integer(id) do
      unauthorized conn
    end
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "edit.html", user: user, user_id: get_session(conn, :user_id), errors: nil
      _ ->
        unauthorized conn
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get(User, String.to_integer(id))
    changeset = User.changeset(user, params)

    if params["newPass"] != params["confirmPass"] do
      changeset = Ecto.Changeset.add_error(changeset, :name, "新密码两次输入不一致!")
    end

    unless User.valid_password?(user, params["oldPass"]) do
      changeset = Ecto.Changeset.add_error(changeset, :name, "原密码不匹配!")
    end

    if changeset.valid? do
      changeset = Ecto.Changeset.put_change(changeset, :password, params["newPass"] |> User.encrypt_password |> to_string)
      Repo.update(changeset)
      render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
    else
      render conn, "edit.html", user: user, errors: changeset.errors, user_id: get_session(conn, :user_id)
    end
  end
end
