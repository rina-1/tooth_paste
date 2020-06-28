class ApplicationController < ActionController::Base
     before_action :configure_permitted_parameters, if: :devise_controller?
  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
        admins_admin_recommends_path
    else
        root_path
    end
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    if resource.is_a?(Admin)
        root_path
    else
        root_path
     end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
