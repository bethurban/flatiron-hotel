class User < ApplicationRecord
  has_many :bookings
  has_many :rooms, through: :bookings
  has_secure_password
  validates :name, presence: true
  validates_format_of :phone_number, with: /\A[1-9]\d{2}-\d{3}-\d{4}/, message: "must be valid - format: XXX-XXX-XXXX"
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /@/
  with_options if: :admin? do |admin|
    admin.validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@flatironhotel\.com\z/,
                  message: "must be a @flatironhotel.com account if you are a hotel manager" }
  end
  validates :password, confirmation: true

end
