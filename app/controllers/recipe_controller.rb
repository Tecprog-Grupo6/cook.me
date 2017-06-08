# File name: recipe_controller.rb
# Class name: RecipeController
# Description: This class control the actions of the Recipe, searches, saves, editions, etc.

class RecipeController < ApplicationController

  before_action :authenticate_user!


  #receives params[:recipe_id] from the url
  #redirects to page of the recipe whose id matches param recipe_id
  def show

    begin
      @to_show_recipe = Recipe.find(params[:recipe_id])
      result = render template: "recipe/show.html.erb"
      logger.debug " [RECIPE#SHOW] Recipe with id: " + params[:recipe_id] + " successfully found"
    rescue ActiveRecord::RecordNotFound
      result = render template: "recipe/recipe_not_found.html.erb"
      logger.debug " [RECIPE#SHOW] URL param recipe_id: " + params[:recipe_id] + ", didn't match an existing recipe id"
    end
    logger.debug " Inspect show if the recipe WAS or WASN'T found"
    return result

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
    logger.debug " Inspect RECIPE SAVED"
    return save(@recipe)
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

  #receives params[:recipe_id] from the url
  #deletes the recipe whose id matches param recipe_id
  #redirects to current user cookbook page
  def delete

    begin
      @to_delete_recipe = Recipe.find(params[:recipe_id])
      @to_delete_recipe.destroy
      if @to_delete_recipe.destroyed?
        logger.debug " [RECIPE#DELETE] Recipe with id: " + @to_delete_recipe.id.to_s + " successfully destroyed"
      else
        logger.debug " [RECIPE#DELETE] Recipe with id: " + @to_delete_recipe.id.to_s + " failed to be destroyed"
      end
    rescue ActiveRecord::RecordNotFound
      logger.debug " [RECIPE#DELETE] URL param recipe_id: " + params[:recipe_id] + ", didn't match an existing recipe id"
    end
    redirect_to "/user/#{current_user.username}"

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
