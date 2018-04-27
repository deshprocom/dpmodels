module TopicNotify
  extend ActiveSupport::Concern
  included do
    after_create :create_notify
  end

  def create_notify
    payload = notify_payload.dup

    TopicNotification.create(payload) if payload.present?
  end

  def notify_payload
    table_name = self.class.table_name
    send("payload_#{table_name}")
  end

  def payload_replies
    # 判断回复的是否是自己 如果是自己就返回false
    return {} if reply_user_id.eql?(user_id)
    { user_id: reply_user_id, from_user_id: user_id, notify_type: 'reply', source: self }
  end

  def payload_comments
    return {} unless notify_needed?
    { user_id: topic.user_id, from_user_id: user_id, notify_type: 'comment', source: self }
  end

  def payload_topic_likes
    return {} unless notify_needed?
    { user_id: topic.user_id, from_user_id: user_id, notify_type: 'topic_like', source: self }
  end

  def user_topic?
    # 判断话题是否是说说或长帖
    topic.class.table_name.eql?('user_topics')
  end

  def notify_needed?
    user_topic? && !user_id.eql?(topic.user_id)
  end
end