class LoginMailer < ApplicationMailer
  def login_link(user)
    @user = user

    mail to: @user.email, subject: 'Přihlašovací odkaz do Copyhat.cz'
  end
end
