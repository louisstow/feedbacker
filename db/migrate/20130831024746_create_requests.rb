class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests, :id => false do |t|
      t.references :campaign
      t.references :user
      t.string :response

      t.timestamps
    end
  end
end
