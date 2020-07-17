class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("user_mailer.acc_activ")
  end

  def password_reset
    @greeting = t "user_mailer.hi"
    mail to: ENV["mail_to"]
  end
end
