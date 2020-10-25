class CreatePurchaseHistoryWebbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_history_webbooks do |t|
      t.references :purchase_history, null: false, foreign_key: true
      t.references :webbook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
