class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :permit_additional_params, if: :clearance_controller?
  before_action :require_login

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: true
  end

  private
  
  def url_after_denied_access_when_signed_out
    signin_path
  end

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
