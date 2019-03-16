class SetActiveDefaultToTrueOnClients < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :active, true
  end
end
