class SessionsController < ApplicationController
  def create
    user = User.where(login_token: params[:token])
      .where('login_token_valid_until > ?', Time.now).first

    if user
      user.update!(login_token: nil, login_token_valid_until: 1.year.ago)

      self.current_user = user
      redirect_to root_path, notice: 'Byl jste úspěšně přihlášen'
    else
      redirect_to root_path, alert: 'Invalid or expired login link'
    end
  end

  def destroy
    self.current_user = NullUser.new
    redirect_to root_path, notice: 'Byl jste úspěšně odhlášen'
  end
end
