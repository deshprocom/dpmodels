module TopicCountable
  extend ActiveSupport::Concern
  included do
    after_create :create_counter
  end

  def increase_page_views
    counter.increment!(:page_views)
  end

  def increase_view_increment(by)
    counter.increment!(:view_increment, by)
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
    counter.decrement!(:comments) if counter.present?
  end

  def decrease_comment_by(by)
    counter.decrement!(:comments, by) if counter.present?
  end

  def increase_reports
    counter.increment!(:reports)
  end

  def decrease_reports
    counter.decrement!(:reports)
  end

  def total_views
    counter.page_views + counter.view_increment
  end

  def total_likes
    counter.likes
  end

  def total_comments
    counter.comments
  end
end




