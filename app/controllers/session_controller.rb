class SessionController < ApplicationController

    def AdminLogin
        @authenticate_user = Admin.find_by(email: params[:email])
        if @authenticate_user.present? && @authenticate_user.authenticate(params[:password])
            flash[:success] = 'Logged in successfully as ' + @authenticate_user.name
            session[:admin_id] = @authenticate_user.id
            @generated_token = generate_and_set_token
            redirect_to dashboard_path( @generated_token)

        else
            flash[:alert] = "Unable to login!"
            render :AdminLogin            
        end

    end

    def new
        @adminUser = Admin.new
    end

    def create
        @search_admin = Admin.find_by(email: admin_params[:email])

        unless @search_admin
          @admin_user = Admin.new(admin_params)
          if @admin_user.save
            @user_token = @admin_user.access_token
            flash[:notice] = "Account successfully created!"
            redirect_to admin_session_path(@user_token)
          else
            flash[:error] = "Unable to create a new account!"
            render :new
          end
        else
          flash[:error] = "Account already exists!"
          redirect_to admin_create_path
        end

        
    end

    def AdminDestroy
        auth0
        session[:admin_id] = nil
        destroyToken
        flash[:notice] = 'Logged out successfully!'
        redirect_to root_path
    end
      

    private

    def admin_params
        params.require(:admin).permit(:name, :email, :password, :password_confirmation)
        
    end

    private
    
end