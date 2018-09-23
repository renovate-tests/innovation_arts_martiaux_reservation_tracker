class CreateGraduations < ActiveRecord::Migration[5.2]
  def change
    create_table :graduations do |t|
      t.integer :student_id, null: false
      t.integer :belt_id, null: false
      t.date :graduation_date, null: false

      t.timestamps
    end
  end
end
