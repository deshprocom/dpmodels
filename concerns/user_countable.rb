module UserCountable
  extend ActiveSupport::Concern
  included do
    after_create :create_counter
  end

  def increase_poker_coins(by)
    counter.increment!(:total_poker_coins, by)
  end

  def increase_long_topics
    counter.increment!(:long_topic_count)
  end

  def decrease_long_topics
    counter.decrement!(:long_topic_count)
  end

  def increase_short_topics
    counter.increment!(:short_topic_count)
  end

  def decrease_short_topics
    counter.decrement!(:short_topic_count)
  end
end




