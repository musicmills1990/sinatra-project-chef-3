class ChangeIngredientsColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :ingredients, :type, :food_type
  end
end
