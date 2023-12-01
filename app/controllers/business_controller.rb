class BusinessController < ApplicationController

    before_action :auth0

    def new
        auth0
        @new_business = @user.build_entity
        
    end

    def create
        if @user.entity.nil?    
            @new_business = @user.build_entity(entity_params)
            if @new_business.save
                flash[:success] = "Business Succesfully updated!"
                redirect_to dashboard_path

            else
                flash[:error] = "Unable to update business entity!"
                render :new
            end
        end
    end

    private
    def entity_params
        params.require(:entity).permit(:name, :service, :address)
        
    end
end