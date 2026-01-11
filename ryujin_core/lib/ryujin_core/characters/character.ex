defmodule RyujinCore.Characters.Character do
  @moduledoc """
  Character schema representing a player's in-game character.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "characters" do
    field :name, :string
    field :level, :integer, default: 1

    # Position
    field :zone_id, :integer
    field :x, :float
    field :y, :float
    field :z, :float
    field :rotation, :float, default: 0.0

    # Appearance
    field :model_id, :integer
    field :head_id, :integer
    field :hair_id, :integer
    field :hair_color_id, :integer
    field :skin_tone_id, :integer
    field :face_paint_id, :integer
    field :model_customization, :string

    # Stats
    field :health, :integer, default: 100
    field :max_health, :integer, default: 100
    field :mana, :integer, default: 100
    field :max_mana, :integer, default: 100

    # Currency
    field :coins, :integer, default: 0
    field :station_cash, :integer, default: 0

    # Profile and titles
    field :active_profile_id, :integer
    field :active_title_id, :integer

    # Chat settings
    field :chat_bubble_color_r, :integer, default: 255
    field :chat_bubble_color_g, :integer, default: 255
    field :chat_bubble_color_b, :integer, default: 255

    belongs_to :user, RyujinCore.Accounts.User
    has_many :items, RyujinCore.Items.Item
    has_many :mounts, RyujinCore.Mounts.Mount
    has_many :titles, RyujinCore.Titles.Title

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [
      :name, :level, :zone_id, :x, :y, :z, :rotation,
      :model_id, :head_id, :hair_id, :hair_color_id,
      :skin_tone_id, :face_paint_id, :model_customization,
      :health, :max_health, :mana, :max_mana,
      :coins, :station_cash, :active_profile_id, :active_title_id,
      :chat_bubble_color_r, :chat_bubble_color_g, :chat_bubble_color_b
    ])
    |> validate_required([:name, :zone_id, :x, :y, :z, :model_id])
    |> validate_length(:name, min: 3, max: 32)
    |> unique_constraint(:name)
  end

  @doc false
  def creation_changeset(character, attrs) do
    character
    |> changeset(attrs)
    |> put_change(:health, 100)
    |> put_change(:max_health, 100)
    |> put_change(:mana, 100)
    |> put_change(:max_mana, 100)
    |> put_change(:level, 1)
  end
end
