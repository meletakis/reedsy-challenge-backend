class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.references :category, index: true, foreign_key: true
      t.integer :volume, null: false, limit: 2
      t.integer :from_num_of_items, null: false, limit: 3
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
