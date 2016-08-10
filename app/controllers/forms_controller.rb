class FormsController < ApplicationController
  def new
  end

  def show
    @form = current_user.forms.find params[:id]
  end

  def index
    @forms = current_user.forms
  end

  def create
    form = Form.new(name: permitted_params[:name], user: current_user)

    if form.save
      permitted_params.fetch(:inputs, []).each do |input|
        FormInput.create(form: form, title: input[:title], input_type: input[:type])
      end

      redirect_to forms_path
    else
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def permitted_params
    params.permit(:name, :id, inputs: [:title, :type])
  end
end
