class TicketEn < ApplicationRecord
  belongs_to :ticket, foreign_key: :id

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
    diff_attrs = %w(title price original_price description)
    assign_attributes ticket.reload.attributes.reject {|k| attributes[k].present? && k.in?(diff_attrs) }
  end
end
