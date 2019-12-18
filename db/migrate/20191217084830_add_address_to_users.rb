class AddAddressToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prefectures, :integer
    add_column :users, :zip_code, :integer
  end
end
