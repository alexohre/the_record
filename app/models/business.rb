class Business < ApplicationRecord
  extend FriendlyId
  
  validates :name, presence: true, uniqueness: true, length: {maximum: 25}

  has_many :members, dependent: :destroy
  has_many :users, through: :members

  has_many :products

  friendly_id :name, use: %i[slugged history finders]
end
