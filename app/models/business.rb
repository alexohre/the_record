class Business < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {maximum: 25}

  has_many :members, dependent: :destroy
  has_many :users, through: :members

  
end
