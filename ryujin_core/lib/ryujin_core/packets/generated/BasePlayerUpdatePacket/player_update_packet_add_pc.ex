defmodule RyujinCore.Packets.PlayerUpdatePacketAddPc do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketAddPc`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketAddPc.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet

  defstruct [
    :guid,
    :model,
    :chat_bubble_foreground_color,
    :chat_bubble_background_color,
    :chat_bubble_size,
    :position,
    :rotation,
    :hair_color,
    :eye_color,
    :max_movement_speed,
    :is_underage,
    :is_member,
    :is_referee,
    :temporary_appearance,
    :active_profile_id,
    :mount_guid,
    :mount_seat,
    :mount_queue_position,
    :name_vertical_offset,
    :wield_type,
    :vip_rank,
    :vip_icon_id,
    :vip_title,
    :unknown17
  ]

  @type t :: %__MODULE__{
          guid: term(),
          model: integer(),
          chat_bubble_foreground_color: integer(),
          chat_bubble_background_color: integer(),
          chat_bubble_size: integer(),
          position: term(),
          rotation: term(),
          hair_color: integer(),
          eye_color: integer(),
          max_movement_speed: float(),
          is_underage: boolean(),
          is_member: boolean(),
          is_referee: boolean(),
          temporary_appearance: integer(),
          active_profile_id: integer(),
          mount_guid: term(),
          mount_seat: integer(),
          mount_queue_position: integer(),
          name_vertical_offset: float(),
          wield_type: integer(),
          vip_rank: float(),
          vip_icon_id: integer(),
          vip_title: integer(),
          unknown17: integer()
        }
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end