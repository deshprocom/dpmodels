class OfflineRaceOrder < ApplicationRecord
  belongs_to :invite_code, optional: true
end
