class AddColumnsToRecipesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipe_first_ingredient, :string
    add_column :recipes, :recipe_second_ingredient, :string
    add_column :recipes, :recipe_third_ingredient, :string
    add_column :recipes, :recipe_fourth_ingredient, :string
    add_column :recipes, :instructions, :text
  end
end
