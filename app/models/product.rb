class Product < ApplicationRecord
  before_validation :generate_sku

  belongs_to :business


  def generate_sku
    self.sku ||= SecureRandom.hex(6).upcase # 6 bytes = 12 characters
  end
end
