class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :enter_with_oauth

  def vkontakte
  end

  def facebook
  end

  def odnoklassniki
  end

  def enter_with_oauth
    @user= User.from_omniauth(oauth_params)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: action_name) if is_navigational_format?
    else
      session["devise.oauth_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private
    def oauth_params
      ActionController::Parameters.new(auth_hash: request.env["omniauth.auth"]).permit!
    end
end
