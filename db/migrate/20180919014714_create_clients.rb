class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :telephone, null: false
      t.string :email, null: false
      t.boolean :active, null: false, default: false
      t.timestamps
    end
  end
end
