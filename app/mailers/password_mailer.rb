class PasswordMailer < ApplicationMailer
  def password_reset
    mail to: params[:user], subject: "Password reset"
  end
end
