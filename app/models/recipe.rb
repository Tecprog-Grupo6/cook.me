class Recipe < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 4}
	belongs_to :user

	# Favorited by users
	has_many :favorite_recipes, class_name: "FavoriteRecipe"
  has_many :favorited_by, through: :favorite_recipes, source: :user

end
