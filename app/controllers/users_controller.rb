class UsersController < ApplicationController

    before_action :authenticate_user!

    def dashboard
        @donations = current_user.donations
        render layout: "dashboard_layout"
    end

    def donation_send
        redirect_to '/my_dashboard', :notice => "Donation succesfully sent"    
    end

    def donation_request

    end

end
