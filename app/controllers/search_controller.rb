######################################################################
# File name: search_controller.rb
# Class name: SearchController
# Description: Controller used to communicate with the view header
######################################################################

class SearchController < ApplicationController
  def index
  end
  # Description: show the results of any search
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
