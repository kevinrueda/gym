# Preview all emails at http://localhost:3000/rails/mailers/happy_birthday_mailer
class HappyBirthdayMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/happy_birthday_mailer/birthday
  def birthday
    HappyBirthdayMailer.birthday
  end

end
