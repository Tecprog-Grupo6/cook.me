class SearchController < ApplicationController
  def index
  end

  def show_results
    @query = params[:query]

    if !(@query.empty?)
      @query_users = User.where("first_name like ?", "%#{@query}%")
    else
      @query_users = nil
    end

    render "search/index"

  end
end
