class RenameClientIdOnStudentsToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :students, :client_id, :user_id
  end
end
