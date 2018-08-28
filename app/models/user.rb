class User < ApplicationRecord
  has_many :bookings
  has_many :rooms, through: :bookings
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /@/
  with_options if: :admin? do |admin|
    admin.validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@flatironhotel\.com\z/,
                  message: "must be a flatironhotel.com account" }
  end
end
