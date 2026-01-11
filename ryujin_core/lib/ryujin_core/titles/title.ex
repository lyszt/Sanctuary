defmodule RyujinCore.Titles.Title do
  @moduledoc """
  Title schema for character-unlocked titles.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "titles" do
    field :title_id, :integer
    field :unlocked_at, :utc_datetime

    belongs_to :character, RyujinCore.Characters.Character

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(title, attrs) do
    title
    |> cast(attrs, [:title_id, :unlocked_at])
    |> validate_required([:title_id, :unlocked_at])
  end
end
