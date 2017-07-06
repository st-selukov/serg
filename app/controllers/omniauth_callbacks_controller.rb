class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_auth
  before_action :user_with_auth
  before_action :signed_in_auth_provider

  def facebook
  end

  def twitter
  end

  private

  def set_auth
    @auth = request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth])
  end

  def user_with_auth
    @user = User.find_for_oauth(@auth)
  end

  def signed_in_auth_provider
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success,
                        kind: params[:action].capitalize if is_navigational_format?
    end
  end
end