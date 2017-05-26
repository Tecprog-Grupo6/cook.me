class FeedController < ApplicationController

  def show
    @recipes_list = Array.new()

    current_user.following do |user|
      user.recipes do |recipe|
        @recipes_list.push(recipe)
      end
    end

    # Sort the list by creation order
    @recipes_list.sort_by{|e| e[:created_at]}.reverse

    return @recipes_list
  end

end
