class UsersController < Clearance::UsersController

  def new
    @user = User.new
    render layout: false
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash.now[:notice] = "Account created successfully. Please log in."
      redirect_to signin_path
    else
      flash.now[:error] = "There was an error creating your account."
      render :new, layout: false
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end