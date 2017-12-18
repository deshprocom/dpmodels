class Dynamic < ApplicationRecord
  belongs_to :typological, polymorphic: true
  belongs_to :user
end
