require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase
  test "reset_password" do
    user = users(:one)
    token = user.generate_token_for(:password_reset)
    mail = PasswordMailer.with(user: user.email, token: token).password_reset
    assert_equal "Password reset", mail.subject
    assert_equal [ user.email ], mail.to
    assert_match /password_reset\/edit\?token=#{URI.encode_www_form_component(token)}/, mail.body.encoded
  end
end
