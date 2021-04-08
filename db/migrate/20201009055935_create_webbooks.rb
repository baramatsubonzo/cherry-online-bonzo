class CreateWebbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :webbooks do |t|
      t.string :title
      t.string :author
      t.text :description
      t.integer :price
      t.date :release_date
      t.boolean :release

      t.timestamps
    end
  end
end
