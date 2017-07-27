class PlayerFollow < ApplicationRecord
  belongs_to :user
  belongs_to :player
end
