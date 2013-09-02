class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :body
      t.references :user

      t.datetime :confirm_deadline
      t.datetime :feedback_deadline

      t.timestamps
    end
  end
end
