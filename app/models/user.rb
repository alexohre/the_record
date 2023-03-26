class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable

  
         
  has_many :members, dependent: :destroy
  has_many :business, through: :members
  
  # belongs_to :user
  def full_name
    self.first_name.capitalize + " " + self.last_name.capitalize
  end
end
