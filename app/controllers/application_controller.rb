class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user
  before_action :redirect_anonymous_users

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by(id: session[:user_id]) || NullUser.new
  end

  private

  def redirect_anonymous_users
    if current_user.anonymous? && request.path != homepage_path
      redirect_to homepage_path
    end
  end
end
