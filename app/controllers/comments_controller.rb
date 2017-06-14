class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.create(comments_params)
    redirect_to show_recipe_path(@recipe)
  end

  private
  def comments_params
   params.require(:comment).permit(:commenter, :body, :recipe_id)

  end
end
