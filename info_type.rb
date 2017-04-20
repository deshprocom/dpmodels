class InfoType < ApplicationRecord
  has_many :infos
  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'
end
