class Crowdfunding < ApplicationRecord
  belongs_to :race
  has_many :players
end
