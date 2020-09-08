class Booking < ApplicationRecord
  belongs_to :permit
  belongs_to :user
end
