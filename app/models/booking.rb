class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :checkin, :checkout, presence: true
  validates :group_size, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, allow_blank: true
  validates_presence_of :room_id, allow_nil: true
end
