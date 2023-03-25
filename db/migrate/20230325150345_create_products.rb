class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :unit
      t.string :sku
      t.boolean :available
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
