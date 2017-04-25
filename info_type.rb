class InfoType < ApplicationRecord
  has_many :infos, dependent: :destroy
  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end
end
