class RegistrationsController < Devise::RegistrationsController

	def create
    super do
    	refferal_email = params[:user][:refferal]
    	root = User.find_by_email(refferal_email)
    	if refferal_email
    		if !root.nil?
    			@user.parent_id = root.id
    		end
    	end
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:name, :btc, :phone, :country, :email, :password, :password_confirmation, :refferal)
    end

    
    def account_update_params
      params.require(:user).permit(:name, :btc, :phone, :country, :email, :password, :password_confirmation, :current_password)
    end
end