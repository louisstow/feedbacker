class RenamePublicInCampaign < ActiveRecord::Migration
  def change
  	rename_column :campaigns, :public, :is_public
  end
end
