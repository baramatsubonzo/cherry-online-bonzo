class CreateCartWebbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_webbooks do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :webbook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
