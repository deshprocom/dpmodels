class RaceEn < ApplicationRecord
  belongs_to :race

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end
end
