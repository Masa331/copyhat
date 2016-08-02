class FormsController < ApplicationController
  def new
  end

  def show
  end

  def index
    @forms = current_user.forms
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
