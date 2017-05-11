######################################################################
# File name: perfil_controller.rb
# Class name: PerfilController
# Description: Controller used to communicate with the view perfil/show
######################################################################

class PerfilController < ApplicationController
  # Description: Shoe the profile of the current user
  # Parameters: none.
  def show
    @current_user = current_user
    @profile_user = User.find_by(username: params[:username])

    if @profile_user != nil
      result = render template: "perfil/show.html.erb"
    else
      result = render template: "perfil/perfil_not_found.html.erb"
    end

    return result
  end
  # Description: follow any profile the user wants
  # Parameters: none.
  def follow
    @user_to_follow = User.find_by(username: params[:username])
    @current_user = User.find_by(username: params[:current_user_username])

    @current_user.follow(@user_to_follow)

    result = redirect_to "/user/" + @user_to_follow.username

    return result
  end
  # Description: unfollow any profile the user follows
  # Parameters: none.
  def unfollow
    @user_to_unfollow = User.find_by(username: params[:username])
    @current_user = User.find_by(username: params[:current_user_username])

    @current_user.unfollow(@user_to_unfollow)

    result = redirect_to "/user/" + @user_to_unfollow.username

    return result
  end
end
