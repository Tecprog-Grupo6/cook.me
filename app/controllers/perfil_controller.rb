class PerfilController < ApplicationController
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

  def follow
    @user_to_follow = User.find_by(username: params[:username])
    @current_user = User.find_by(username: params[:current_user_username])

    @current_user.follow(@user_to_follow)

    result = redirect_to "/user/" + @user_to_follow.username

    return result
  end

  def unfollow
    @user_to_unfollow = User.find_by(username: params[:username])
    @current_user = User.find_by(username: params[:current_user_username])

    @current_user.unfollow(@user_to_unfollow)

    result = redirect_to "/user/" + @user_to_unfollow.username

    return result
  end
end
