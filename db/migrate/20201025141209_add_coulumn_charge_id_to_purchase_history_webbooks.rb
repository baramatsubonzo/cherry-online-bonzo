class AddCoulumnChargeIdToPurchaseHistoryWebbooks < ActiveRecord::Migration[6.0]
  def up
    add_column :purchase_history_webbooks, :charge_id, :string
  end

  def down
    remove_column :purchase_history_webbooks, :charge_id, :string
  end
end
