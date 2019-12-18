class AddColumnsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :designer, :string, default: "unknown", null: false
    add_column :products, :sale, :boolean, default: false, null: false
    add_column :products, :size, :string, default: "M", null: false
  end
end
