class RemoveTagsFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :tags
  end
end
