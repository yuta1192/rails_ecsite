class AddEvaluationToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :evaluation, :integer
  end
end
