class UsersController < ApplicationController

    before_action :authenticate_user!

    def dashboard

        @donations = current_user.donations.order('created_at DESC')
        @requests = current_user.requests.order('created_at DESC')
        render layout: "dashboard_layout"
      
    end

    def donation_send
        if params[:value]
         current_user.send_donation(donation_params.to_i)
         redirect_to '/my_dashboard', :notice => "Donation succesfully sent" 
        end   
    end

    def donation_request
        raise
    end

private
    def donation_params
      params.permit(:value)
    end

end
