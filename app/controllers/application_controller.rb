class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :permit_additional_params, if: :clearance_controller?

  private

  def permit_additional_params
    Clearance.configuration.user_parameter = :user
    params[:user] &&= user_params
  end

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def clearance_controller?
    self.class.ancestors.include? Clearance::Controller
  end
end
