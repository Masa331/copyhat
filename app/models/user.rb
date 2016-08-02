class User < ApplicationRecord
  has_many :forms

  def anonymous?
    false
  end
end
