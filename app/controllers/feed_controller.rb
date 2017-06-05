class FeedController < ApplicationController

  def show
    if user_signed_in?
      @recipes_list = Array.new()

      current_user.following.each do |user|
        user.recipes.each do |recipe|
          @recipes_list.push(recipe)
        end
      end

      # Sort the list by creation order
      @recipes_list = @recipes_list.sort_by{|e| e[:created_at]}.reverse
      @profile_user = current_user

      result = render template: "feed/show.html.erb"
      return result
    else
      result = render template: "home/index.html.erb"
      return result
    end
  end

end
