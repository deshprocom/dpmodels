class RaceEn < ApplicationRecord
  belongs_to :race, foreign_key: :id
end
