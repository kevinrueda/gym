require "test_helper"

class HappyBirthdayMailerTest < ActionMailer::TestCase
  test "birthday" do
    mail = HappyBirthdayMailer.birthday
    assert_equal "Birthday", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
