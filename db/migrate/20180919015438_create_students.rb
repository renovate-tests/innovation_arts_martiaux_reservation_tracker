class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.date :date_of_birth
      t.boolean :active, default: true
      t.integer :client_id, null: false
      t.boolean :trial_class
      t.boolean :uniform_promotion
      t.timestamps

      t.index :client_id
      t.index :belt_id
    end
  end
end
