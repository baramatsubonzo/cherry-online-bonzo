class AddRowOrderToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :row_order, :integer
  end
end
