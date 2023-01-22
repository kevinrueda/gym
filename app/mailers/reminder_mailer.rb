class ReminderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.subscription.subject
  #
  def subscription
    @customer = params[:customer]
    mail to: @customer.email, subject: 'Renovación de suscripción'
  end
end
