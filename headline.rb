class Headline < ApplicationRecord
  include Publishable

  belongs_to :source, polymorphic: true
  attr_accessor :source_title
  validates :title, presence: true
  validates :source_type, presence: true
  validates :source_id, presence: true

  def source_title
    return if source.nil?

    source[:name] || source[:title]
  end
end
