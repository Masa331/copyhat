class Form < ApplicationRecord
  belongs_to :user

  has_many :data_entries,
    dependent: :destroy

  has_many :inputs,
    class_name: :FormInput,
    dependent: :destroy

  def link
    'https://copyhat.com/forms/tvuj-form'
  end
end

# == Schema Information
#
# Table name: forms
#
#  id         :integer          not null, primary key
#  name       :string
#  visible    :boolean
#  public_id  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
