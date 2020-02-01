class AddColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :release, :boolean, default: false, null: false
  end
end
