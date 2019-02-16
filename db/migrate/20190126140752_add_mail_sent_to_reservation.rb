class AddMailSentToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :mail_sent, :boolean, default: false
    add_index :reservations, :mail_sent
  end
end
