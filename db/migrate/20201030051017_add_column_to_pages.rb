class AddColumnToPages < ActiveRecord::Migration[6.0]
  def up
    add_column :pages, :page_number, :integer, null: false
  end

  def down
    remove_column :pages, :page_number, :integer, null: false
  end
end
