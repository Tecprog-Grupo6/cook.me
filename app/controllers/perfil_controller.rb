class PerfilController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])

    if @user != nil
      result = render template: "perfil/show.html.erb"
    else
      result = render template: "perfil/perfil_not_found.html.erb"
    end

    return result
  end
end
