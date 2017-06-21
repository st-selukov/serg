class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def parent_klass
    controller_name.classify.constantize
  end

  def find_parent
    @parent = parent_klass.find(params[:id])
  end
end
