class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_auth_for_confirm, only: [:auth_confirm_email]
  before_action :set_auth, expect: [:auth_confirm_email]
  before_action :signed_in_auth_provider, expect: [:auth_confirm_email]

  def facebook
  end

  def twitter
  end

  def auth_confirm_email
  end

  private

  def set_auth_for_confirm
    @auth = OmniAuth::AuthHash.new(provider: session[:provider],
                                   uid: session[:uid],
                                   info: {email: params[:auth][:info][:email]})
    signed_in_auth_provider
  end

  def set_auth
    @auth = request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth])
  end

  def signed_in_auth_provider
    @user = User.find_for_oauth(@auth)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success,
                        kind: params[:action].capitalize if is_navigational_format?
    else
      session[:provider] = @auth.provider
      session[:uid] = @auth.uid
      render 'omniauth_callbacks/confirm_email'
    end
  end
end