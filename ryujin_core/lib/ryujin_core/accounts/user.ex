defmodule RyujinCore.Accounts.User do
  @moduledoc """
  User account schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :username, :string
    field :password_hash, :string
    field :email, :string
    field :session_key, :binary
    field :last_login, :utc_datetime

    # Virtual fields for password handling
    field :password, :string, virtual: true

    has_many :characters, RyujinCore.Characters.Character

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email])
    |> validate_required([:username, :password])
    |> validate_length(:username, min: 3, max: 32)
    |> validate_length(:password, min: 6, max: 128)
    |> validate_format(:email, ~r/@/, message: "must be a valid email")
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  @doc false
  def session_changeset(user, attrs) do
    user
    |> cast(attrs, [:session_key, :last_login])
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # TODO: Use proper password hashing (Argon2/bcrypt)
    put_change(changeset, :password_hash, password)
  end

  defp put_password_hash(changeset), do: changeset
end
