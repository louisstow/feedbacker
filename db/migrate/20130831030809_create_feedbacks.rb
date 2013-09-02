class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :campaign
      t.references :user
      t.text :body
      
      t.timestamps
    end
  end
end
