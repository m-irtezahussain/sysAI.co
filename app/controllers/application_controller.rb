class ApplicationController < ActionController::Base
    def auth0
        if session[:admin_id].present?
            @current_user = session[:admin_id] 
            @user = Admin.find_by(id: @current_user)
            @current_session = @user.id
            @token = @user.access_token

        else
            flash[:alert] = "Login first!"
            redirect_to root_path
        end
    end

    def generate_and_set_token

        token = SecureRandom.hex(16)
        expiration_time = 24.hour.from_now
        session[:token] = { value: token, expires_at: expiration_time }
    end

    def expirationToken
        generate_and_set_token

        token_info = session[:token]

        if token_info && token_info[:expires_at] <= Time.now
            flash[:alert] = 'Token has expired. Please log in again.'
            redirect_to admin_session_path
        end
    end

    def destroyToken
        generate_and_set_token
        
        session[:token] = nil
    end

    def current_business
        auth0

        @current_business = @user.business
        if @current_business.nil?
            flash[:alert] = 'No business found!'
            redirect_to business_registration_path

        else
            @business = @current_business.id
        end

    end
end
