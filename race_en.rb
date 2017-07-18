class RaceEn < ApplicationRecord
  belongs_to :race, foreign_key: :id

  before_save do
    diff_attrs = %w(name prize location ticket_price blind)
    assign_attributes race.reload.attributes.reject { |k| attributes[k].present? && k.in?(diff_attrs) }
  end

  enum status: [:unbegin, :go_ahead, :ended, :closed]
end
