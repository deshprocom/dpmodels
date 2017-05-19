class Video < ApplicationRecord
  belongs_to :video_type

  before_save do
    self.description = ActionController::Base.helpers.strip_tags(description)
  end

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  scope :published, -> { where(published: true) }
  scope :topped, -> { where(top: true) }

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end

  def top!
    update(top: true)
  end

  def untop!
    update(top: false)
  end
end
