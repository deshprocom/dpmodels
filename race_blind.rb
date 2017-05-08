class RaceBlind < ApplicationRecord
  belongs_to :race

  validates :level, numericality: { greater_than: 0 }
  validates :content, presence: true, if: :blind_content?

  enum blind_type: [:blind_struct, :blind_content]
  scope :level_asc, -> { order(level: :asc).order(blind_type: :asc) }
end
