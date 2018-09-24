class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :course_type_id, null: false
      t.integer :timeslot_id, null: false
      t.integer :age_group_id, null: false
      t.integer :number_of_students_allowed
      t.integer :day_of_week, null: false

      t.timestamps

      t.index :course_type_id
      t.index :timeslot_id
      t.index :age_group_id
      t.index :day_of_week
    end
  end
end
