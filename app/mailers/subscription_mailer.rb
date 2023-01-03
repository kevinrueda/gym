class SubscriptionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription_mailer.invoice.subject
  #
  def invoice
    @subscription = params[:subscription]

    mail to: @subscription.customer.email
  end
end
