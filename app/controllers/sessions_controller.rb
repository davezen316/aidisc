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