class ApplicationController < ActionController::Base
  protected
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.client?
      client_root_path
    else
      super
    end
  end
end
