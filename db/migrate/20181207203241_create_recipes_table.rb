class CreateRecipesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
