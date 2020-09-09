class Booking < ApplicationRecord
  STATUS = ["Awaiting", "Booked", "Declined"]
  belongs_to :permit
  belongs_to :user
  validates :status, inclusion: { in: Booking::STATUS}
end
