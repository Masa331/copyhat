class Form < ApplicationRecord
  belongs_to :user

  has_many :data_entries
  has_many :form_inputs
end
