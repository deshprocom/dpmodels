class InfoType < ApplicationRecord
  has_many :infos, dependent: :destroy
  has_one :info_type_en, foreign_key: 'id', dependent: :destroy
  accepts_nested_attributes_for :info_type_en, allow_destroy: true

  after_update do
    info_type_en.save
  end

  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'

  def publish!
    update(published: true)
  end

  def unpublish!
    update(published: false)
  end
end
