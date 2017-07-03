require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :gon_user, unless: :devise_controller?

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
end
