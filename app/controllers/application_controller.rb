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
#   def configure_permitted_parameters
#     added_attrs = [:]
#     devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
#     devise_parameter_sanitizer.permit :account_update, keys: added_attrs
#   end


#     protect_from_forgery with: :exception

#     helper_method :current_user, :logged_in?

#     private

#     # def current_user
#     #   return unless session[:user_id]
#     #   @current_user ||= SocialProfile.find(session[:social_profile_id])
#     # end

#     def logged_in?
#       !!session[:social_profile_id]
#     end

#     def authenticate
#       return if logged_in?
#       redirect_to root_path, alert: 'ログインしてください'
# end

end
