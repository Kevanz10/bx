class RegistrationsController < Devise::RegistrationsController
  layout "dashboard_layout.html", only: [:edit]
  
  protected
  
    def after_sign_up_path_for(resource)
      '/my_dashboard' # Or :prefix_to_your_route
    end

  private
    
    def sign_up_params
      params.require(:user).permit(:name, :btc, :phone, :country, :email, :password, :password_confirmation)
    end

    
    def account_update_params
      params.require(:user).permit(:name, :btc, :phone, :country, :email, :password, :password_confirmation, :current_password)
    end
end