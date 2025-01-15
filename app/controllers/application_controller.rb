class ApplicationController < ActionController::Base
	before_action :configure_permitted_params, if: :devise_controller?

	protected

	def authenticate_admin
		unless current_user.admin?
			redirect_to root_path, notice: 'You are not allowed'
		end
	end

	def configure_permitted_params
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo, :phone])
	end
end
