class RaceSchedule < ApplicationRecord
  belongs_to :race
  after_initialize do
    self.begin_time ||= Time.current
  end
end
