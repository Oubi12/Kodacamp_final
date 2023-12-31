class ApplicationController < ActionController::Base

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource) if is_navigational_format?
  end



  def after_sign_in_path_for(resource)
    if resource.admin?
      if request.referer && request.referer.include?("/client")
        client_root_path
      else
        admin_root_path
      end
    else
      client_root_path
    end
  end
end

#  def after_sign_in_path_for(resource)
#     if resource.admin?
#       admin_root_path
#     else
#       client_root_path
#     end
#   end

