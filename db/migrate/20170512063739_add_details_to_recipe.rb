class AddDetailsToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :served_people, :integer
    add_column :recipes, :prepare_time, :integer
  end
end
