class Dynamic < ApplicationRecord
  # belongs_to :typological, polymorphic: true
  belongs_to :typological, -> { unscope(:where) }, polymorphic: true
  belongs_to :user

  def self.received_message
    where.not(typological_type: 'TopicLike')
  end

  def deleted_type?
    option_type.eql?('delete')
  end
end
