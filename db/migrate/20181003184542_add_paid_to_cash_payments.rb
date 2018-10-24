class AddPaidToCashPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :cash_payments, :paid, :boolean, default: false
  end
end
