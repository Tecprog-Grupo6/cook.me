######################################################################
# File name: recipes_controller.rb
# Class name: RecipesController
# Description: Controller used to communicate with the view /recipes
######################################################################

class RecipesController < ApplicationController
	# show all recipes
	def index
		@recipes = Recipe.all
	end

	# show an specific recipe
	def show
		@recipe = Recipe.find(params[:id])
	end

	# create a new recipe
	def new
		@recipe = Recipe.new
	end

	# edit a recipe
	def edit
		@recipe = Recipe.find(params[:id])
	end

	# create a recipe
	def create
		@recipe = Recipe.new(params[:recipe].permit(:title,:text))
		#method to save a new recipe
		if @recipe.save
			redirect_to @recipe
		else
			render 'new'
		end
	end

	# method to update a specific recipe
	def update
		@recipe = Recipe.find(params[:id])

		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	# method to exclude a recipe
	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy

		redirect_to @recipe
	end

	# create the parameters to recipes list
	private
	def recipe_params
		params.require(:recipe).permit(:title, :text)
	end
end
