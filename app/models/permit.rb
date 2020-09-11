class Permit < ApplicationRecord
  PERKS = ["travel", "free things", "no curfew", "uniform"]
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
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
