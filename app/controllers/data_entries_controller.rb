class DataEntriesController < ApplicationController
  def create
    form = current_user.forms.find permitted_params[:form_id]
    other_params = permitted_params.except :form_id

    DataEntry.create(form: form, inputs: other_params)

    redirect_to form_path form
  end

  private

  def permitted_params
    # TODO: Nejak odsanitizovat
    params.require(:data_entry).permit!
  end
end
