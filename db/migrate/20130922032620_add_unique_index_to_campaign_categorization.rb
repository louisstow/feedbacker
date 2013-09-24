class AddUniqueIndexToCampaignCategorization < ActiveRecord::Migration
  def change
  	add_index :campaign_categorizations, [:campaign_id, :category_id], :unique => true
  end
end
