class Room < ApplicationRecord
  has_many :users
  has_many :users, through: :bookings
end
