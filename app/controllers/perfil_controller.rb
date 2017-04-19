class PerfilController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])

    if @user != nil
      result = render template: "perfil/show.html.erb"
    else
      # Profile not found page
    end

    return result
  end
end
