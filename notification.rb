class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :user
  serialize :extra_data

  after_create do
    DpPush::NotifyUser.call(user, content) unless Rails.env.test?
  end

  def self.notify_order(order)
    title, content = notify_order_info(order)
    extra_data = { order_number: order.order_number, image: order.race.preview_logo }
    Notification.create(notify_type: 'order',
                        user_id: order.user_id,
                        source: order,
                        extra_data: extra_data,
                        color_type: 'success',
                        content: content,
                        title: title)
  end

  def self.notify_certification(user_extra)
    title = '实名认证'
    color_type, content = notify_certification_info(user_extra)
    Notification.create(notify_type: 'certification',
                        user_id: user_extra.user_id,
                        source: user_extra,
                        color_type: color_type,
                        content: content,
                        title: title)
  end

  def self.notify_order_info(order)
    case order.status
    when 'unpaid'
      %w(下单成功 恭喜您，下单成功！客服将及时与您联系，请保持手机通话畅通)
    when 'paid'
      %w(付款成功 付款成功!)
    when 'delivered'
      ['已发票', "您已成功参与#{order.race.name}，请及时查收预留的收货方式收取赛票，感谢您对扑客的支持！"]
    when 'completed'
      ['订单完成', "#{order.race.name}的订单已完成"]
    end
  end

  def self.notify_certification_info(extra)
    if extra.failed?
      ['failure', "实名认证失败，请重新上传信息认证！失败原因: #{extra.memo}"]
    elsif extra.passed?
      %w(success 实名认证成功!)
    end
  end
end
