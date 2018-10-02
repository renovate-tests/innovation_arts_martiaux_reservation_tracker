class AddNameTelephoneActiveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :telephone, :string
    add_column :users, :active, :boolean, default: false

    drop_table :clients

  end
end
