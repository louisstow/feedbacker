class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.text :body
      t.references :feedback

      t.timestamps
    end
  end
end
