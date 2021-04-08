class ChangeReleaseOfWebbooks < ActiveRecord::Migration[6.0]
  def up
    change_column :webbooks, :release, :boolean, default: false, null: false
  end

  def down
    change_column :webbooks, :release, :boolean
  end
end
