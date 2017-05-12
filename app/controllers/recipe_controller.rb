class RecipeController < ApplicationController

  def show

  end

  def new
    result = render template: "recipe/new.html.erb"
    return result
  end

  def save
    @recipe = Recipe.new(:title => params[:name], :text => params[:preparation])

      if @recipe.save
        redirect_to "/receita/visualizar/#{@recipe.id}"
      else
        redirect_to '/receita/criar'
      end
  end

  def edit

  end

  def delete

  end

end
