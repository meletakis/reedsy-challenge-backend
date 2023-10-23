class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :category, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :price_in_cents, null: false

      t.timestamps
    end
  end
end
