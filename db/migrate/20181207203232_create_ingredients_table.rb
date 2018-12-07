class CreateIngredientsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :fridge_freezer_item
      t.string :pantry_item
      t.string :spice_cabinet_item
      t.integer :user_id
    end
  end
end
