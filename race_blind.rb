class RaceBlind < ApplicationRecord
  belongs_to :race

  validates :level, numericality: { greater_than: 0 }

  enum blind_type: [:blind_struct, :content]
  scope :level_asc, -> { order(level: :asc).order(blind_type: :asc) }
end
