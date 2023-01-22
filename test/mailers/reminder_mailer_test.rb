require "test_helper"

class ReminderMailerTest < ActionMailer::TestCase
  test "subscription" do
    mail = ReminderMailer.subscription
    assert_equal "Subscription", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
