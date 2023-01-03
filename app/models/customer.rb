class Customer < ApplicationRecord
  validates :name, presence: true
  validates :dni, presence: true, uniqueness: true, numericality: { only_numeric: true }
  validates :email, presence: true

  has_many :subscriptions, dependent: :destroy
  has_many :trainings, dependent: :destroy
  has_many :attendances, dependent: :destroy

  def info
    "#{self.name} - [#{self.dni}]"
  end

  def subscription_status
    if self.subscriptions.exists?
      if self.subscriptions.last.end >= DateTime.current.to_date
        self.subscriptions.last.end
      else
        false
      end
    else
      false
    end
  end

  def self.expired_subscription
    Customer.joins(:subscriptions).where("subscriptions.end" => DateTime.current.to_date)
  end
end
