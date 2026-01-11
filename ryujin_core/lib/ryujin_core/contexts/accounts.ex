defmodule RyujinCore.Accounts do
  @moduledoc """
  The Accounts context handles user authentication and management.
  """

  import Ecto.Query
  alias RyujinCore.Repo
  alias RyujinCore.Accounts.User

  @doc """
  Gets a single user by ID.
  """
  def get_user(id) do
    Repo.get(User, id)
  end

  @doc """
  Gets a user by username.
  """
  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  @doc """
  Creates a new user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Authenticates a user by username and password.
  Returns {:ok, user} on success, {:error, reason} on failure.
  """
  def authenticate(username, password) do
    user = get_user_by_username(username)

    cond do
      is_nil(user) ->
        # Run password hash to prevent timing attacks
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      verify_password(password, user.password_hash) ->
        {:ok, user}

      true ->
        {:error, :invalid_credentials}
    end
  end

  @doc """
  Updates user session key (for active session tracking).
  """
  def update_session_key(user, session_key) do
    user
    |> User.session_changeset(%{session_key: session_key, last_login: DateTime.utc_now()})
    |> Repo.update()
  end

  # Private Functions

  defp verify_password(password, hash) do
    # TODO: Use Argon2 or bcrypt for production
    # For now, simple comparison (insecure - replace later!)
    password == hash
  end

  defp hash_password(password) do
    # TODO: Use Argon2 or bcrypt for production
    # For now, just return the password (insecure - replace later!)
    password
  end
end
