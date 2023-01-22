class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true, numericality: { only_numeric: true }
  validates :email, presence: true
  validates :birth_date, presence: true

  has_many :subscriptions, dependent: :destroy
  has_many :trainings, dependent: :destroy
  has_many :attendances, dependent: :destroy

  def info
    if self.subscription_status
      "#{self.name} - [#{self.phone}] - [#{self.subscription_status.strftime('%d/%m/%Y')}]"
    else
      "#{self.name} - [#{self.phone}]"
    end
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

  def self.birthday
    customers = Customer.all
    customers_birthday = []
    customers.each do |customer|
      if customer.birth_date.month === DateTime.current.month && customer.birth_date.day === DateTime.current.day
        customers_birthday.append customer
      end
    end
    customers_birthday
  end

  def age
    age = Date.today.year - self.birth_date.year
    age -= 1 if Date.today < self.birth_date + age.years
    age
  end

  def self.subscription_reminder
    customers_reminder = []
    customers = Customer.all
    customers.each do |customer|
      if customer.subscription_status
        if customer.subscriptions.last.end - 3.days <= DateTime.current.to_date
          customers_reminder.append customer
        end
      end
    end
    customers_reminder
  end
end
