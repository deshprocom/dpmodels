class RaceRank < ApplicationRecord
  belongs_to :race
  belongs_to :player
end
