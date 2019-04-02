class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_number, :cost, :capacity, :image
  has_many :bookings
  has_many :users, through: :bookings
end
