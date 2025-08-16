require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user one" do
    user = users(:one)
    assert_equal "user_one@example.org", user.email
    assert user.id.present?
  end

  test "generate token for password reset" do
    user = users(:one)
    token = user.generate_token_for(:password_reset)
    assert token.present?
    assert_equal user, User.find_by_token_for(:password_reset, token)
  end

  test "password reset token expires in 15 minutes" do
    user = users(:one)
    token = user.generate_token_for(:password_reset)
    assert token.present?
    travel 16.minutes
    assert_not User.find_by_token_for(:password_reset, token)
  end

  test "normalize email" do
    user = User.new(email: "ABc@example.org")
    user.valid?
    assert_equal "abc@example.org", user.email
  end

  test "default user role is user" do
    user = User.new
    assert user.user?
    assert_not user.admin?
  end

  test "admin user" do
    user = users(:admin)
    assert user.admin?
    assert_not user.user?
  end

  test "regular user" do
    user = users(:one)
    assert user.user?
    assert_not user.admin?
  end
end
