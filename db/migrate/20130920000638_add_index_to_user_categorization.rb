class AddIndexToUserCategorization < ActiveRecord::Migration
  def change
  	add_index :user_categorizations, [:user_id, :category_id]
  end
end
