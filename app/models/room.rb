class Room < ApplicationRecord
  has_many :guests
  has_many :guests, through: :bookings
end
