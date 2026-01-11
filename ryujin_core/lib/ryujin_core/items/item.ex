defmodule RyujinCore.Items.Item do
  @moduledoc """
  Item schema for character inventory and equipment.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "items" do
    field :item_definition_id, :integer
    field :quantity, :integer, default: 1
    field :slot, :integer
    field :is_equipped, :boolean, default: false
    field :durability, :integer
    field :tint_id, :integer
    field :metadata, :string

    belongs_to :character, RyujinCore.Characters.Character

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:item_definition_id, :quantity, :slot, :is_equipped, :durability, :tint_id, :metadata])
    |> validate_required([:item_definition_id])
    |> validate_number(:quantity, greater_than: 0)
  end
end
