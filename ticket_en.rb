class TicketEn < ApplicationRecord
  belongs_to :ticket, foreign_key: :id

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
end
