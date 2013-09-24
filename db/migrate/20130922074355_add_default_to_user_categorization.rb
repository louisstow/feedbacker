class AddDefaultToUserCategorization < ActiveRecord::Migration
  def change
  	change_column :user_categorizations, :score, :integer, :default => 1
  end
end
