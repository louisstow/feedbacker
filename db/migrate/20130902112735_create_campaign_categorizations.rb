class CreateCampaignCategorizations < ActiveRecord::Migration
  def change
    create_table :campaign_categorizations, id: false do |t|
    	t.references :campaign
    	t.references :category
    end
  end
end
