class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }

  enum :role, %i[user admin], default: :user

  validates :email, presence: true, uniqueness: true

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  def avatar_url
    "https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.jpg"
  end
end
