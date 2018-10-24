class CreateCashPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_payments do |t|
      t.integer :user_id, null: false
      t.date :due_date, null: false

      t.timestamps
    end
  end
end
