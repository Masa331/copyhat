require 'csv_builder'

class FormsController < ApplicationController
  def new
  end

  def show
    @form = current_user.forms.find params[:id]

    respond_to do |format|
      format.html
      format.csv do
        send_data CsvBuilder.call(@form.data_entries), filename: "data-export.csv", type: 'text/csv'
      end
    end
  end

  def index
    @forms = current_user.forms
  end

  def create
    form = Form.new(name: permitted_params[:name], user: current_user)
    form.save
    permitted_params.fetch(:inputs, []).each do |input|
      input = FormInput.new(title: input[:title], input_type: input[:type])
      form.inputs << input
    end

    respond_to do |format|
      format.js do
        if form.persisted? && form.inputs.all?(&:persisted?)
          render json: { redirect: forms_url }.to_json
        else
          render json: { failure: "General error occured" }.to_json
        end
      end
    end
  end

  def destroy
    @form = current_user.forms.find params[:id]
    @form.destroy

    redirect_to forms_path, notice: 'Formulář byl smazán'
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
