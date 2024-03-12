class DashboardController < ApplicationController
  before_action :require_login

  def show
    if current_user.disc_test_results.any?
      # The user has completed at least one DISC test
      # Redirect to the latest DISC test result page
      latest_result = current_user.disc_test_results.last
      redirect_to disc_test_result_path(latest_result)
    else
      # The user has not completed any DISC tests
      # Render the view with the DISC test form
      render 'disc_tests/new'
    end
  end
end