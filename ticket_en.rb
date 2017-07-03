class TicketEn < ApplicationRecord
  belongs_to :ticket

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
end
