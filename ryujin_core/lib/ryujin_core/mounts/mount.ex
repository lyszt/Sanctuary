defmodule RyujinCore.Mounts.Mount do
  @moduledoc """
  Mount schema for character-owned mounts.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "mounts" do
    field :mount_definition_id, :integer
    field :is_active, :boolean, default: false

    belongs_to :character, RyujinCore.Characters.Character

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(mount, attrs) do
    mount
    |> cast(attrs, [:mount_definition_id, :is_active])
    |> validate_required([:mount_definition_id])
  end
end
