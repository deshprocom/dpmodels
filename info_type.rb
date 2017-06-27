class InfoType < ApplicationRecord
  has_many :infos, dependent: :destroy
  has_one  :eng_info_type
  accepts_nested_attributes_for :eng_info_type

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end
end
