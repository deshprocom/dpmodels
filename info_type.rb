class InfoType < ApplicationRecord
  has_many :infos, dependent: :destroy
  has_one  :eng_info_type

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end
end
