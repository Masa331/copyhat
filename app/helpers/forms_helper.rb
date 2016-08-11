module FormsHelper
  def create_form(form)
    inputs = create_inputs(form)
    hiddens = create_hiddens(form)

    form_tag data_entries_path do
      [inputs + hiddens].join.html_safe
    end
  end

  private

  def create_inputs(form)
    @form.form_inputs.map do |input|
      create_input(input)
    end.flatten
  end

  def create_input(input)
    if input.input_type == 'submit'
      create_submit(input)
    else
      create_standard_input(input)
    end
  end

  def create_standard_input(input)
    send("#{input.input_type}_field_tag", "data_entry[#{input.title}]")
  end

  def create_submit(input)
    submit_tag input.title
  end

  def create_label(input)
    label_tag input.title
  end

  def create_hiddens(form)
    [hidden_field_tag('data_entry[form_id]', @form.id)]
  end
end
