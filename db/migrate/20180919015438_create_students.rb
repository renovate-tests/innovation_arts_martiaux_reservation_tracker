class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.date :date_of_birth
      t.boolean :active, default: true
      t.integer :client_id, null: false
      t.integer :belt_id, null: false
      t.timestamps
    end
  end
end
