class RenameFinishFlagColumnToFinishedFlag < ActiveRecord::Migration[5.2]
  def change
    rename_column :product_purchases, :finish_flag, :finished_flag
  end
end
