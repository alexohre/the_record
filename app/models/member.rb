class Member < ApplicationRecord
  belongs_to :user
  belongs_to :business

  enum :roles, [:admin, :staff]
end
