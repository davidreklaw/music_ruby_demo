class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name])
        end

        def after_sign_in_path_for(resource)
            songs_path
        end
end
