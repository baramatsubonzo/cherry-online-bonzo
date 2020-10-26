class AddColumnToPurchaseHistoryWebbooks < ActiveRecord::Migration[6.0]
  def up
    change_column :purchase_history_webbooks, :charge_id, :string, null: false
  end

  def down
    change_column :purchase_history_webbooks, :charge_id, :string
  end
end
