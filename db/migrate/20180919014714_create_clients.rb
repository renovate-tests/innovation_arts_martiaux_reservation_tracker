class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :telephone
      t.string :email
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
