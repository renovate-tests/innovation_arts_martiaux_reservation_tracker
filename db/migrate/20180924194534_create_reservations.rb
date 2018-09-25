class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.boolean :active, default: true

      t.timestamps

      t.index :student_id
      t.index :course_id
    end
  end
end
