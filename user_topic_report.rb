class UserTopicReport < ApplicationRecord
  belongs_to :user_topic, optional: true
  belongs_to :user, optional: true
  belongs_to :report_user, class_name: 'User', foreign_key: :report_user_id, optional: true
  enum report_type: { short: 'short', long: 'long', im: 'im' }

  def ignored!
    update(ignored: true)
    user_topic.decrease_reports if user_topic?
  end

  def user_topic?
    report_type.eql?('short') || report_type.eql?('long')
  end

  def topic_title
    return '' unless user_topic?
    return user_topic.title if report_type.eql?('long')
    user_topic.body
  end

  def report_times
    user_topic? ? user_topic.total_reports : 0
  end
end