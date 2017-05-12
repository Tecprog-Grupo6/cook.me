class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(:first_name => params[:user][:first_name], :last_name =>
      params[:user][:last_name], :email => params[:user][:email],:password =>
      params[:user][:password], :password_confirmation =>
      params[:user][:password_confirmation], :username =>
      params[:user][:username], :avatar => params[:user][:avatar])

    if @user.save
      sign_in(:user, @user)
      render 'home/index'
    else
      render 'users/registrations/new'
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update

    @user_edit = current_user

    if @user_edit.valid_password?(params[:user][:current_password])

      @user_edit.first_name = params[:user][:first_name]
      @user_edit.last_name = params[:user][:last_name]
      @user_edit.email = params[:user][:email]

      if params[:user][:password].empty? || params[:user][:password_confirmation].empty?
        @user_edit.password = params[:user][:current_password]
        @user_edit.password_confirmation = params[:user][:current_password]
      else
        @user_edit.password = params[:user][:password]
        @user_edit.password_confirmation = params[:user][:password_confirmation]
      end

      if params[:user][:avatar] != nil
        @user_edit.avatar = params[:user][:avatar]
      else
        # Do nothing
      end

      if @user_edit.save
        sign_out @user_edit
        sign_in @user_edit

        # Set @user to database state to render profile
        @profile_user = User.find_by(username: current_user.username)
        render template: "perfil/show.html.erb"
      else
        #Set @user to get error messages from @user_edit
        @user = @user_edit
        render template: "users/registrations/edit.html.erb"
      end

    else
       flash[:notice] = "A senha digitada está incorreta!"
       redirect_to "/perfil/editar"
    end

  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
