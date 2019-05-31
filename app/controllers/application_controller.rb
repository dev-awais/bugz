class ApplicationController < ActionController::Base
	
  include Pundit
  before_action :authenticate_user!
	
  protect_from_forgery with: :exception

     before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    protected

    def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :user_type, :email, :password)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :user_type, :email, :password, :current_password)}

               devise_parameter_sanitizer.permit(:user_type)
	end
  private
  def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
  end

end
