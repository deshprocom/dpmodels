class Info < ApplicationRecord
  belongs_to :info_type
  default_scope { where(published: true) } unless ENV['CURRENT_PROJECT'] == 'dpcms'
end
