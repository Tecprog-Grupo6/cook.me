class RecipesController < ApplicationController
	def index
		@recipes = Recipe.all		
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
	end

	def create
		@recipe = Recipe.new(params[:recipe].permit(:title,:text))

		@recipe.save
		redirect_to @recipe
	end

	def index
		@recipes = Recipe.all		
	end

	private
	def recipe_params
		params.require(:recipe).permit(:title,:text)		
	end
end
