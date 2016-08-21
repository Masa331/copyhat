class DataEntry < ApplicationRecord
  belongs_to :form
end

# == Schema Information
#
# Table name: data_entries
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  inputs     :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
