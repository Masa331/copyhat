class User < ApplicationRecord
  has_many :forms

  def anonymous?
    false
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string
#  name                    :string
#  login_token             :string
#  login_token_valid_until :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
