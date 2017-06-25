class SearchController < ApplicationController

  def index
  end

  def get_query
    redirect_to "/buscar/#{params[:query]}"
  end

  def get_results

    @query = params[:query]

    if !(@query.empty?)
      @query_users = User.where("first_name like ?", "%#{@query}%")
      @query_recipe = Recipe.where("title like ?", "%#{@query}%")
    else
      @query_users = nil
      @query_recipe = nil
    end

    result = render template: "search/index.html.erb"
    return result

  end

end
