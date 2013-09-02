class AddTypeToCampaigns < ActiveRecord::Migration
  def change
  	add_column :campaigns, :public, :boolean
  end
end
