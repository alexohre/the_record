class AddSlugToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :slug, :string
    add_index :businesses, :slug, unique: true
  end
end
