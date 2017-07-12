module ControllerMacros
  def sign_in_user
    before do
      @user = create(:user, confirmed_at: Time.now)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end
end
