class Activity < ApplicationRecord
  mount_uploader :pushed_img, ActivityUploader
  mount_uploader :banner, ActivityUploader

  after_initialize do
    self.activity_time ||= Date.current
  end

  def push!
    update(pushed: true)
  end

  def unpush!
    update(pushed: false)
  end

  def preview_banner
    return '' if banner.url.nil?

    banner.url(:sm)
  end

  def preview_pushed_img
    return '' if pushed_img.url.nil?

    pushed_img.url(:sm)
  end
end
