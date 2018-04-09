module UserTopicCountable
  extend ActiveSupport::Concern
  included do
    after_create :create_counter
  end

  def increase_page_views
    counter.increment!(:page_views)
  end

  def increase_likes
    counter.increment!(:likes)
  end

  def decrease_likes
    counter.decrement!(:likes)
  end

  def increase_comments
    counter.increment!(:comments)
  end

  def decrease_comments
    counter.decrement!(:comments)
  end
end