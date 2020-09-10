class Permit < ApplicationRecord
  PERKS = ["travel", "free food", "no curfew"]
  validates :name, presence: true
  validates :perks, presence: true


  has_one_attached :photo
  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_by_perks,
    against: [ :perks ],
    using: {
      tsearch: { prefix: true }
    }
end
