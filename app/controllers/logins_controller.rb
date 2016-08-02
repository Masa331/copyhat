class LoginsController < ApplicationController
  skip_before_action :redirect_anonymous_users

  def new
  end

  def create
    user = User.find_or_create_by!(email: params[:email]) do |user|
      user.name = 'Edit me!'
    end

    user.update!(login_token: SecureRandom.urlsafe_base64,
                 login_token_valid_until: Time.now + 15.minutes)

    LoginMailer.login_link(user).deliver

    redirect_to root_path, notice: 'Na váš e-mail byl odeslán přihlašovací odkaz'
  end
end
