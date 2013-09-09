class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :user_categorizations do |t|
      t.references :category
      t.references :user
    end
  end
end
