class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :permission_user

  private

  def after_sign_in_path_for(resource)
    if resource.role == 'admin'
      admin_path
    else
      root_path
    end
  end

  def permission_user
    if params[:controller].split("/").first == 'admin' && current_user.role == 'employee'
      redirect_to root_path
    end
  end
end
