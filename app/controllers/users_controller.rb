class UsersController < Clearance::UsersController

  def new
    @user = User.new
    render layout: false
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Account created successfully. Please log in."
      redirect_to signin_path
    else
      flash.now[:error] = "There was an error creating your account."
      render :new, layout: false
    end
  end

  def edit_password
    # Renders the form
  end

  def update_password
    user = current_user
    if current_user.authenticated?(params[:current_password])
      if current_user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
        flash[:notice] = 'Password was successfully updated.'
        redirect_to profile_path # or wherever you wish
      else
        flash.now[:alert] = 'There was a problem updating your password.'
        render :edit_password
      end
    else
      flash.now[:alert] = 'Current password is incorrect.'
      render :edit_password
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end