# File name: recipe_controller.rb
# Class name: RecipeController
# Description: This class control the actions of the Recipe, searches, saves, editions, etc.

class RecipeController < ApplicationController

  skip_before_action :verify_authenticity_token

  def show

    # Searching a recipe
    @recipe_posted = Recipe.find(params[:recipe_id])
    logger.debug " Inspect a valid found recipe"

    if @recipe_posted != nil
      result = render template: "recipe/show.html.erb"
      logger.debug " Inspect recipe FOUND!"
    else
      result = render template: "recipe/recipe_not_found.html.erb"
      logger.debug " recipe NOT FOUND!"
    end
    return result
    logger.debug " Inspect show if the recipe WAS or WASN'T found"
  end

  def new
    result = render template: "recipe/new.html.erb"
    return result
  end

  def save_new
    @recipe = current_user.recipes.create(:title => params[:recipes][:title],
                                          :text => params[:recipes][:text],
                                          :served_people => params[:recipes][:served_people],
                                          :prepare_time => params[:recipes][:prepare_time],
                                          :image_one => params[:recipes][:image_one])
    return save(@recipe)
    logger.debug " Inspect RECIPE SAVED"

  end

  def save_old
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.assign_attributes(:title => params[:recipes][:title],
                              :text => params[:recipes][:text],
                              :served_people => params[:recipes][:served_people],
                              :prepare_time => params[:recipes][:prepare_time],
                              :image_one => params[:recipes][:image_one])
    return save(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    result = render template: "recipe/edit.html.erb"
    return result
  end

  def delete
    #[TODO]
  end

  private
  def save (to_save_recipe)
    if to_save_recipe.save
      redirect_to "/receita/visualizar/#{@recipe.id}"
    else
      redirect_to '/receita/criar/'
    end
  end

end
