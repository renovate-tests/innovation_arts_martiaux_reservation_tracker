class AddDurationUniformToTarifs < ActiveRecord::Migration[5.2]
  def change
    add_column :tarifs, :duration, :string
    add_column :tarifs, :uniform_promotion, :boolean, default: false

    remove_column :students, :uniform_promotion, :boolean
  end
end
