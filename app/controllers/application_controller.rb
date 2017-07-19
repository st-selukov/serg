require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :gon_user, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protected

  def gon_user
    gon.user_id = current_user.id if current_user
  end

  def parent_klass
    controller_name.classify.constantize
  end

  def find_parent
    @parent = parent_klass.find(params[:id])
  end

  private

  def user_not_authorized
    flash[:alert] = "Вы не имеете доступ к данному действию"
    redirect_to(request.referrer || root_path)
  end
end
