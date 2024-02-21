# class SessionsController < Clearance::SessionsController
#   def new
#     Rails.logger.debug "Custom SessionsController new action invoked"
#     render layout: false
#   end

#   def create
#     @user = authenticate(params)

#     sign_in(@user) do |status|
#       if status.success?
#         redirect_back_or url_after_create
#       else
#         flash.now.notice = status.failure_message
#         render template: "sessions/new", layout: false
#       end
#     end

#     if @user.save
#       flash[:success] = "Account created successfully. Please log in."
#       redirect_to sign_in_path
#     else
#       flash.now[:error] = "There was an error creating your account."
#       render :new, layout: false
#     end
#   end
# end

class SessionsController < Clearance::SessionsController
  def new
    Rails.logger.debug "Custom SessionsController new action invoked"
    render layout: false
  end

  def create
    Rails.logger.debug "Custom SessionsController create action invoked"

    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_to url_after_create
      else
        flash.now[:error] = status.failure_message
        # Render the sign-in form again without the layout
        render :new, layout: false
      end
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end  

  protected
  
  def url_after_create
    root_path
  end
end