class CreateTarifs < ActiveRecord::Migration[5.2]
  def change
    create_table :tarifs do |t|
      t.integer :class_per_week, null: false
      t.float :price, default: 0.00

      t.timestamps
    end
  end
end
