class Booking < ApplicationRecord
  STATUS = ["Awaiting", "Booked", "Declined"]
  belongs_to :permit
  belongs_to :user
  validate :status, inclusion: { in: Booking::STATUS}
end
