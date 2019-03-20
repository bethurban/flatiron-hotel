class BookingSerializer < ActiveModel::Serializer
  attributes :id, :group_size, :checkin, :checkout
  belongs_to :room
  belongs_to :user
end
