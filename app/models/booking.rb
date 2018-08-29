class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :checkin, :checkout, :user_id, :room_id, presence: true
  validates :group_size, presence: true, numericality: { only_integer: true }

  def date_range
    Range.new(self.checkin, self.checkout)
  end

end
