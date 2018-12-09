class CreateNewIngredientsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :item
      t.string :type
      t.string :user_id
      t.timestamps null: false
    end
  end
end
