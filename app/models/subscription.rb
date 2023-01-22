class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :plan

  def is_active
    (self.start..self.end) === DateTime.current.to_date
  end

  def self.day_total
    time_range = Time.now.midnight..(Time.now.midnight + 1.day)
    data = Subscription.joins(:plan).where('subscriptions.created_at' => time_range).group('date(subscriptions.created_at)').select('date(subscriptions.created_at) AS dia, sum(plans.price) AS total')
    if data.exists?
      data.first.total
    else
      0
    end

  end

  def self.month_total
    time_range = Date.today.beginning_of_month..Date.today.end_of_month
    data = Subscription.joins(:plan).where('subscriptions.created_at' => time_range).group('date(subscriptions.created_at)').select('sum(plans.price) AS total')
    if data.exists?
      total = 0
      data.each do |dia|
        total += dia.total
      end
      total
    else
      0
    end
  end
end
