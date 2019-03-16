class DropTrialFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :trial_class
  end
end
