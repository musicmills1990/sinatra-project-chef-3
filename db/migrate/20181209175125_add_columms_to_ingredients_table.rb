class AddColummsToIngredientsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :item, :string
    add_column :ingredients, :type, :string
  end
end
