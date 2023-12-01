class DashboardController < ApplicationController

    before_action :auth0
    before_action :expirationToken

    def main
        @user_entity = @user.entity
        
    end

    def work
        
    end
end