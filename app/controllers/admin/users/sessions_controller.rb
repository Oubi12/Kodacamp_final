# frozen_string_literal: true

class Admin::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  class Admin::Users::SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]
    before_action :check_user_role, only: [:create]

    private

    def check_user_role
      user = User.find_by(email: params[:admin_user][:email])

      if user && user.admin?
        sign_in(user, scope: :user) # Manually sign in the user
      else
        flash[:alert] = "This login is only for admin."
        redirect_to new_admin_user_session_path
      end
    end
  end
end
