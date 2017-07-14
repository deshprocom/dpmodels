class InfoType < ApplicationRecord
  has_many :infos, dependent: :destroy
  # has_one  :info_type_en, dependent: :destroy
  # accepts_nested_attributes_for :info_type_en, allow_destroy: true

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end
end
