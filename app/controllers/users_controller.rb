class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def edit
    @user = @user.find(params[:id])
  end

  def update
    User.find(params[:id]).update!(name: params[:user][:name])

    redirect_to users_path
  end

  private

  def authenticate_user!
    if current_user.anonymous?
      redirect_to root_path, alert: 'Not authenticated'
    end
  end
end
