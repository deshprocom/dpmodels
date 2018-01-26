class PokerCoin < ApplicationRecord
  belongs_to :user
  belongs_to :typeable, polymorphic: true

  after_save do
    user.increase_poker_coins(number)
  end
end
