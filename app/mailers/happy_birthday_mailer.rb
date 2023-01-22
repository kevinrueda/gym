class HappyBirthdayMailer < ApplicationMailer
  def birthday(customer)
    @customer = customer

    mail to: @customer.email, subject: "Feliz Cumpleaños 🎂"
  end
end
