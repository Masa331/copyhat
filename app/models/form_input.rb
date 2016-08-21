class FormInput < ApplicationRecord
  belongs_to :form

end

# == Schema Information
#
# Table name: form_inputs
#
#  id         :integer          not null, primary key
#  title      :string
#  input_type :string
#  form_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
