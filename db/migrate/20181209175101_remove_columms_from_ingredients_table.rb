class RemoveColummsFromIngredientsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :fridge_freezer_item
    remove_column :ingredients, :pantry_item
    remove_column :ingredients, :spice_cabinet_item
  end
end
