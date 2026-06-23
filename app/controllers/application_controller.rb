class ApplicationController < ActionController::Base
	before_action :configure_permitted_params, if: :devise_controller?

	protected

	def authenticate_admin
		return if current_user.admin?

		path = (current_user ? budgets_path : root_path)
		redirect_to path, alert: 'Você não tem permissão para essa ação'
	end

	def configure_permitted_params
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo, :phone])
	end
end
