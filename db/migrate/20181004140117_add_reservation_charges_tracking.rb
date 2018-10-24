class AddReservationChargesTracking < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_charges_tracking do |t|
      t.integer :user_id, null: false
      t.integer :reservation_id, null: false
      t.string :charge_id, null: false
      t.boolean :paid, null: false, default: false
    end
  end
end
