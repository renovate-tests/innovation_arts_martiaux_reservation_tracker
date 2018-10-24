class CreateAgeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :age_groups do |t|
      t.string :name, null: false
      t.integer :min_age, null: false
      t.integer :max_age, null: false

      t.timestamps
    end
  end
end
