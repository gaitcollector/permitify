class Permit < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
