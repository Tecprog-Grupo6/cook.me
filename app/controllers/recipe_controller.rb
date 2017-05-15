class RecipeController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:save]

  def show

  end

  def new
    result = render template: "recipe/new.html.erb"
    return result
  end

  def save_new

    @recipe = Recipe.new(:title => params[:name], :text => params[:preparation], :served_people => params[:people], :prepare_time => params[:time])
    return save(@recipe)
  end

  def save_old

    @recipe = Recipe.find(params[:recipe_id])
    @recipe.assign_attributes(:title => params[:name], :text => params[:preparation], :served_people => params[:people], :prepare_time => params[:time])
    return save(@recipe)
  end

  def edit
    result = render template: "recipe/edit.html.erb"
    return result
  end

  def delete

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
