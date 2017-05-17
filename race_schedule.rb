class RaceSchedule < ApplicationRecord
  belongs_to :race
  after_initialize do
    self.begin_time ||= Time.current
  end

  scope :default_order, -> { order(begin_time: :asc, schedule: :asc) }
  scope :default_asc, -> { order(begin_time: :asc, schedule: :asc) }
end
