class AddRateToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :rate, :int
  end
end
