class AddScoreToUserCategory < ActiveRecord::Migration
  def change
  	add_column :user_categorizations, :score, :integer
  end
end
