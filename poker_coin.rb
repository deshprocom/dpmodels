class PokerCoin < ApplicationRecord
  belongs_to :user
  belongs_to :typeable, polymorphic: true
end
