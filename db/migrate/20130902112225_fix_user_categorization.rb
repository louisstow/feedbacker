class FixUserCategorization < ActiveRecord::Migration
  def change
  	remove_column :user_categorizations, :id
  end
end
